import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    this.countryName,
    this.isCrypto = false,
  });

  final String code;
  final String name;
  final String symbol;
  final String? countryName;
  final bool isCrypto;

  int get fractionDigits => isCrypto ? 8 : 2;

  @override
  List<Object?> get props => [code];
}
