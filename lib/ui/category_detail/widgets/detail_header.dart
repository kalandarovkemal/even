import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.label,
    required this.total,
    this.negative = false,
  });

  final String label;
  final String total;
  final bool negative;

  @override
  Widget build(BuildContext context) {
    final color = negative ? AppColors.danger : AppColors.accent;
    final glow = negative ? AppColors.dangerMedium : AppColors.accentGlow;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.fieldLabel),
          const SizedBox(height: AppSpacing.sm),
          Text(
            total,
            style: AppTypography.heroTotal.copyWith(
              color: color,
              shadows: [
                Shadow(color: glow, blurRadius: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
