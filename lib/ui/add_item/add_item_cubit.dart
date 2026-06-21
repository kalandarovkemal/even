import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/entry_category.dart';
import '../../domain/entities/ledger_entry.dart';
import '../../domain/entities/money.dart';
import '../../domain/repositories/ledger_repository.dart';
import 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit({
    required LedgerRepository ledger,
    required String initialCurrency,
    Uuid? uuid,
  })  : _ledger = ledger,
        _uuid = uuid ?? const Uuid(),
        super(AddItemState.initial(initialCurrency));

  final LedgerRepository _ledger;
  final Uuid _uuid;

  void setCategory(EntryCategory category) =>
      emit(state.copyWith(category: category));

  void setName(String name) => emit(state.copyWith(name: name));

  void setAmount(String amount) => emit(state.copyWith(amount: amount));

  void setCurrency(String code) => emit(state.copyWith(currencyCode: code));

  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final now = DateTime.now();
    final entry = LedgerEntry(
      id: _uuid.v4(),
      category: state.category,
      name: state.name.trim(),
      money: Money(amount: state.parsedAmount!, currencyCode: state.currencyCode),
      createdAt: now,
      updatedAt: now,
    );
    await _ledger.upsert(entry);
    return true;
  }
}
