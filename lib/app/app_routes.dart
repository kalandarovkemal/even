import 'package:flutter/material.dart';

import '../domain/entities/currency.dart';
import '../domain/entities/entry_category.dart';
import '../ui/category_detail/category_detail_screen.dart';
import '../ui/currency_picker/currency_picker_screen.dart';
import '../ui/edit_item/edit_item_screen.dart';

abstract final class AppRoutes {
  static Future<void> openCategory(BuildContext context, EntryCategory category) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoryDetailScreen(category: category),
      ),
    );
  }

  static Future<void> openEditItem(BuildContext context, String entryId) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditItemScreen(entryId: entryId),
      ),
    );
  }

  static Future<Currency?> pickCurrency(
    BuildContext context, {
    required String selectedCode,
  }) {
    return Navigator.of(context).push<Currency>(
      MaterialPageRoute(
        builder: (_) => CurrencyPickerScreen(selectedCode: selectedCode),
      ),
    );
  }
}
