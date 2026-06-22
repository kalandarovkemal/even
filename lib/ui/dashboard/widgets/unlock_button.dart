import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../paywall/purchase_cubit.dart';
import '../../paywall/purchase_state.dart';
import '../../paywall/paywall_sheet.dart';

class UnlockButton extends StatelessWidget {
  const UnlockButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseCubit, PurchaseState>(
      builder: (context, state) {
        if (state.unlocked) {
          return const SizedBox.shrink();
        }
        return GestureDetector(
          onTap: () => PaywallSheet.show(context),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
              border: Border.all(color: AppColors.accentBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium,
                    size: 16, color: AppColors.accent),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  AppLocalizations.of(context).unlock,
                  style: AppTypography.itemNote.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
