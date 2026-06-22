import 'package:flutter/material.dart';

import '../../../core/i18n/category_l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/entry_category.dart';
import '../../../l10n/app_localizations.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final EntryCategory selected;
  final ValueChanged<EntryCategory> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          for (final category in EntryCategory.values)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(category),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: category == selected
                        ? AppColors.surfaceElevated
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                  child: Text(
                    l10n.categoryTitle(category).toUpperCase(),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.fieldLabel.copyWith(
                      color: category == selected
                          ? AppColors.textPrimary
                          : AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
