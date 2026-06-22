import 'package:equatable/equatable.dart';

class PurchaseState extends Equatable {
  const PurchaseState({
    required this.unlocked,
    required this.pending,
    required this.price,
    this.justFailed = false,
    this.justSucceeded = false,
  });

  const PurchaseState.initial(this.price)
      : unlocked = false,
        pending = false,
        justFailed = false,
        justSucceeded = false;

  final bool unlocked;
  final bool pending;
  final String price;
  final bool justFailed;
  final bool justSucceeded;

  PurchaseState copyWith({
    bool? unlocked,
    bool? pending,
    String? price,
    bool justFailed = false,
    bool justSucceeded = false,
  }) =>
      PurchaseState(
        unlocked: unlocked ?? this.unlocked,
        pending: pending ?? this.pending,
        price: price ?? this.price,
        justFailed: justFailed,
        justSucceeded: justSucceeded,
      );

  @override
  List<Object?> get props =>
      [unlocked, pending, price, justFailed, justSucceeded];
}
