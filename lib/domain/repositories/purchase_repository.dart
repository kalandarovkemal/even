enum PurchasePhase { idle, pending, purchased, restored, cancelled, error }

abstract interface class PurchaseRepository {
  Future<void> init();

  Stream<bool> watchUnlocked();

  Future<bool> isUnlocked();

  String? get formattedPrice;

  Stream<PurchasePhase> get phases;

  Future<void> buy();

  Future<void> restore();

  Future<void> dispose();
}
