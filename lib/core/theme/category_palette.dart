import 'package:flutter/widgets.dart';

import '../../domain/entities/entry_category.dart';
import 'app_colors.dart';

class CategoryPalette {
  const CategoryPalette({required this.foreground, required this.background});

  final Color foreground;
  final Color background;

  static CategoryPalette of(EntryCategory category) => switch (category) {
        EntryCategory.lent || EntryCategory.debt => const CategoryPalette(
            foreground: AppColors.danger,
            background: AppColors.dangerSoft,
          ),
        EntryCategory.balance => const CategoryPalette(
            foreground: AppColors.accent,
            background: AppColors.accentSoft,
          ),
      };
}
