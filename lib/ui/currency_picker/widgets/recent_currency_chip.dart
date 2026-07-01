import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class RecentCurrencyChip extends StatelessWidget {
  const RecentCurrencyChip({
    super.key,
    required this.code,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  final String code;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentSoft : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.surfaceBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              code,
              style: AppTypography.itemName.copyWith(
                fontSize: 14,
                color: selected ? AppColors.accent : AppColors.textPrimary,
              ),
            ),
            if (selected) ...[
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.check_circle, color: AppColors.accent, size: 16),
            ] else if (locked) ...[
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.lock_outline, color: AppColors.textMuted, size: 14),
            ],
          ],
        ),
      ),
    );
  }
}
