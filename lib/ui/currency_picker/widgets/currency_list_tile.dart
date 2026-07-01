import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/currency.dart';

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({
    super.key,
    required this.currency,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  final Currency currency;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        child: Ink(
          decoration: BoxDecoration(
            color: selected ? AppColors.accentSoft : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(
              color: selected ? AppColors.accentBorder : AppColors.surfaceBorder,
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: selected
                    ? AppColors.accentSoft
                    : AppColors.surfaceElevated,
                child: Text(
                  currency.symbol,
                  style: AppTypography.itemName.copyWith(
                    color: selected ? AppColors.accent : AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      currency.name,
                      style: AppTypography.itemName.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(currency.code, style: AppTypography.itemNote),
                  ],
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: AppColors.accent, size: 22)
              else if (locked)
                const Icon(Icons.lock_outline,
                    color: AppColors.textMuted, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
