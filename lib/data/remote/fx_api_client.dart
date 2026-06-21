import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;

class FxApiClient {
  FxApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static const String _fiatHost = 'open.er-api.com';
  static const String _cryptoHost = 'api.coingecko.com';

  Future<Map<String, Decimal>> fetchUnitsPerBase({
    required String base,
    required List<String> targets,
  }) async {
    final result = <String, Decimal>{};
    final fiatTargets = targets.where((c) => c != 'BTC').toSet();
    final wantsCrypto = targets.contains('BTC');

    if (fiatTargets.isNotEmpty || base != 'BTC') {
      result.addAll(await _fetchFiat(base, fiatTargets));
    }
    if (wantsCrypto) {
      final btc = await _fetchBtcUnitsPerBase(base);
      if (btc != null) {
        result['BTC'] = btc;
      }
    }
    return result;
  }

  Future<Map<String, Decimal>> _fetchFiat(String base, Set<String> targets) async {
    final uri = Uri.https(_fiatHost, '/v6/latest/$base');
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw FxApiException('Fiat rates request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (body['result'] != 'success') {
      throw FxApiException('Fiat rates request returned ${body['result']}');
    }
    final rates = body['rates'] as Map<String, dynamic>;
    final out = <String, Decimal>{};
    rates.forEach((code, value) {
      if (targets.isEmpty || targets.contains(code)) {
        out[code] = Decimal.parse(value.toString());
      }
    });
    return out;
  }

  Future<Decimal?> _fetchBtcUnitsPerBase(String base) async {
    final vs = base.toLowerCase();
    final uri = Uri.https(_cryptoHost, '/api/v3/simple/price', {
      'ids': 'bitcoin',
      'vs_currencies': vs,
    });
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw FxApiException('Crypto price request failed: ${response.statusCode}');
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final bitcoin = body['bitcoin'] as Map<String, dynamic>?;
    final price = bitcoin?[vs];
    if (price == null) {
      return null;
    }
    final priceDecimal = Decimal.parse(price.toString());
    if (priceDecimal == Decimal.zero) {
      return null;
    }
    return (Decimal.one / priceDecimal).toDecimal(scaleOnInfinitePrecision: 12);
  }
}

class FxApiException implements Exception {
  FxApiException(this.message);

  final String message;

  @override
  String toString() => 'FxApiException: $message';
}
