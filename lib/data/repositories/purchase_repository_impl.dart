import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../../core/config/monetization.dart';
import '../../domain/repositories/purchase_repository.dart';
import '../../domain/repositories/settings_repository.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  PurchaseRepositoryImpl(this._settings, {InAppPurchase? iap})
      : _iap = iap ?? InAppPurchase.instance;

  final SettingsRepository _settings;
  final InAppPurchase _iap;

  final StreamController<PurchasePhase> _phases =
      StreamController<PurchasePhase>.broadcast();
  StreamSubscription<List<PurchaseDetails>>? _sub;

  ProductDetails? _product;
  bool _available = false;

  @override
  Stream<PurchasePhase> get phases => _phases.stream;

  @override
  String? get formattedPrice => _product?.price;

  @override
  Future<void> init() async {
    _available = await _iap.isAvailable();
    if (!_available) {
      return;
    }
    _sub = _iap.purchaseStream.listen(
      _onPurchases,
      onError: (_) => _phases.add(PurchasePhase.error),
    );
    final response =
        await _iap.queryProductDetails({Monetization.lifetimeProductId});
    if (response.productDetails.isNotEmpty) {
      _product = response.productDetails.first;
    }
  }

  @override
  Stream<bool> watchUnlocked() => _settings.watchUnlocked();

  @override
  Future<bool> isUnlocked() => _settings.isUnlocked();

  @override
  Future<void> buy() async {
    final product = _product;
    if (!_available || product == null) {
      _phases.add(PurchasePhase.error);
      return;
    }
    _phases.add(PurchasePhase.pending);
    await _iap.buyNonConsumable(
      purchaseParam: PurchaseParam(productDetails: product),
    );
  }

  @override
  Future<void> restore() async {
    if (!_available) {
      _phases.add(PurchasePhase.error);
      return;
    }
    _phases.add(PurchasePhase.pending);
    await _iap.restorePurchases();
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.productID != Monetization.lifetimeProductId) {
        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);
        }
        continue;
      }
      switch (purchase.status) {
        case PurchaseStatus.purchased:
          await _settings.setUnlocked(true);
          _phases.add(PurchasePhase.purchased);
        case PurchaseStatus.restored:
          await _settings.setUnlocked(true);
          _phases.add(PurchasePhase.restored);
        case PurchaseStatus.error:
          _phases.add(PurchasePhase.error);
        case PurchaseStatus.canceled:
          _phases.add(PurchasePhase.cancelled);
        case PurchaseStatus.pending:
          _phases.add(PurchasePhase.pending);
      }
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  @override
  Future<void> dispose() async {
    await _sub?.cancel();
    await _phases.close();
  }
}
