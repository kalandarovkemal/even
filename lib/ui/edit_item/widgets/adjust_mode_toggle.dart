import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/transfer_destination.dart';
import '../../../l10n/app_localizations.dart';

class AdjustModeToggle extends StatelessWidget {
  const AdjustModeToggle({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final AdjustMode mode;
  final ValueChanged<AdjustMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final option in AdjustMode.values)
            GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: option == mode
                      ? AppColors.textPrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
                ),
                child: Text(
                  option == AdjustMode.subtract ? l10n.subtract : l10n.add,
                  style: AppTypography.itemNote.copyWith(
                    color: option == mode
                        ? AppColors.background
                        : AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
