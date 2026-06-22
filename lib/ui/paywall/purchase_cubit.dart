import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/monetization.dart';
import '../../domain/repositories/purchase_repository.dart';
import 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  PurchaseCubit(this._repo)
      : super(PurchaseState.initial(
          _repo.formattedPrice ?? Monetization.fallbackPrice,
        ));

  final PurchaseRepository _repo;

  StreamSubscription<bool>? _unlockedSub;
  StreamSubscription<PurchasePhase>? _phaseSub;

  void start() {
    _unlockedSub = _repo.watchUnlocked().listen(
          (unlocked) => emit(state.copyWith(unlocked: unlocked)),
        );
    _phaseSub = _repo.phases.listen(_onPhase);
  }

  void _onPhase(PurchasePhase phase) {
    switch (phase) {
      case PurchasePhase.pending:
        emit(state.copyWith(pending: true));
      case PurchasePhase.purchased:
      case PurchasePhase.restored:
        emit(state.copyWith(pending: false, justSucceeded: true));
      case PurchasePhase.error:
        emit(state.copyWith(pending: false, justFailed: true));
      case PurchasePhase.cancelled:
        emit(state.copyWith(pending: false));
      case PurchasePhase.idle:
        emit(state.copyWith(pending: false));
    }
  }

  Future<void> buy() => _repo.buy();

  Future<void> restore() => _repo.restore();

  @override
  Future<void> close() {
    _unlockedSub?.cancel();
    _phaseSub?.cancel();
    return super.close();
  }
}
