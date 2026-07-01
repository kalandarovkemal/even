import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../l10n/app_localizations.dart';
import 'purchase_cubit.dart';
import 'purchase_state.dart';

class PaywallSheet extends StatelessWidget {
  const PaywallSheet({super.key, this.note});

  final String? note;

  static Future<void> show(BuildContext context, {String? note}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<PurchaseCubit>(),
        child: PaywallSheet(note: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      listenWhen: (prev, curr) =>
          prev.unlocked != curr.unlocked ||
          curr.justSucceeded ||
          curr.justFailed,
      listener: (context, state) {
        if (state.justSucceeded || state.unlocked) {
          Navigator.of(context).maybePop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.purchaseThanks)),
          );
        } else if (state.justFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.purchaseFailed)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<PurchaseCubit>();
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
          ),
          padding: EdgeInsets.only(
            left: AppSpacing.screenPadding,
            right: AppSpacing.screenPadding,
            top: AppSpacing.xl,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: const BoxDecoration(
                    color: AppColors.accentSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.workspace_premium,
                      color: AppColors.accent, size: 28),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(l10n.paywallTitle, style: AppTypography.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.paywallSubtitle, style: AppTypography.itemNote),
                if (note != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    note!,
                    style: AppTypography.itemNote
                        .copyWith(color: AppColors.danger),
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                Text(l10n.paywallFeatures, style: AppTypography.itemName),
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: state.pending ? '…' : l10n.unlock,
                  onPressed: state.pending ? null : cubit.buy,
                ),
                const SizedBox(height: AppSpacing.sm),
                Center(
                  child: TextButton(
                    onPressed: state.pending ? null : cubit.restore,
                    child: Text(
                      l10n.restore,
                      style: AppTypography.itemNote
                          .copyWith(color: AppColors.textPrimary),
                    ),
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
