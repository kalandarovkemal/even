import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../category_sort.dart';

class SortMenuButton extends StatelessWidget {
  const SortMenuButton({
    super.key,
    required this.current,
    required this.onSelected,
  });

  final CategorySort current;
  final ValueChanged<CategorySort> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PopupMenuButton<CategorySort>(
      initialValue: current,
      onSelected: onSelected,
      color: AppColors.surface,
      itemBuilder: (context) => [
        for (final sort in CategorySort.values)
          PopupMenuItem<CategorySort>(
            value: sort,
            child: Text(
              _sortLabel(l10n, sort),
              style: AppTypography.itemNote.copyWith(
                color: sort == current
                    ? AppColors.accent
                    : AppColors.textPrimary,
              ),
            ),
          ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.sort,
            style: AppTypography.itemNote.copyWith(color: AppColors.accent),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.accent),
        ],
      ),
    );
  }
}

String _sortLabel(AppLocalizations l10n, CategorySort sort) => switch (sort) {
      CategorySort.amountDesc => l10n.sortAmountDesc,
      CategorySort.amountAsc => l10n.sortAmountAsc,
      CategorySort.nameAsc => l10n.sortNameAsc,
    };
