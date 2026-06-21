import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class HeroTotal extends StatelessWidget {
  const HeroTotal({
    super.key,
    required this.totalText,
    required this.totalNegative,
    required this.displayCode,
    required this.onCurrencyTap,
  });

  final String totalText;
  final bool totalNegative;
  final String displayCode;
  final VoidCallback onCurrencyTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final totalColor = totalNegative ? AppColors.danger : AppColors.accent;
    final glowColor = totalNegative ? AppColors.dangerMedium : AppColors.accentGlow;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            l10n.currentPortfolio.toUpperCase(),
            style: AppTypography.heroLabel,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${l10n.totalLabel.toUpperCase()}: ', style: AppTypography.heroTotal),
              Flexible(
                child: Text(
                  totalText,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.heroTotal.copyWith(
                    color: totalColor,
                    shadows: [
                      Shadow(color: glowColor, blurRadius: 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: onCurrencyTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.accentBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayCode,
                        style: AppTypography.badge.copyWith(
                          color: AppColors.accent,
                          letterSpacing: 1,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        size: 12,
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            width: 64,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
            ),
          ),
        ],
      ),
    );
  }
}
