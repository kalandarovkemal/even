import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

class Money extends Equatable {
  const Money({required this.amount, required this.currencyCode});

  factory Money.parse(String amount, String currencyCode) =>
      Money(amount: Decimal.parse(amount), currencyCode: currencyCode);

  factory Money.zero(String currencyCode) =>
      Money(amount: Decimal.zero, currencyCode: currencyCode);

  final Decimal amount;
  final String currencyCode;

  Money copyWith({Decimal? amount, String? currencyCode}) => Money(
        amount: amount ?? this.amount,
        currencyCode: currencyCode ?? this.currencyCode,
      );

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return copyWith(amount: amount + other.amount);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return copyWith(amount: amount - other.amount);
  }

  bool get isNegative => amount < Decimal.zero;

  void _assertSameCurrency(Money other) {
    if (other.currencyCode != currencyCode) {
      throw ArgumentError(
        'Currency mismatch: $currencyCode vs ${other.currencyCode}',
      );
    }
  }

  @override
  List<Object?> get props => [amount, currencyCode];
}
