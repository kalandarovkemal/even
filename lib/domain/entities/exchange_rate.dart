import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  const ExchangeRate({
    required this.base,
    required this.target,
    required this.rate,
    required this.fetchedAt,
  });

  final String base;
  final String target;
  final Decimal rate;
  final DateTime fetchedAt;

  @override
  List<Object?> get props => [base, target, rate];
}
