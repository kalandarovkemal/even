import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/transfer_destination.dart';
import '../../../l10n/app_localizations.dart';
import '../edit_item_cubit.dart';
import '../edit_item_state.dart';
import 'active_record_card.dart';
import 'adjust_mode_toggle.dart';
import 'destination_option.dart';
import 'transfer_amount_field.dart';
import 'wallet_chip.dart';

class EditItemBody extends StatelessWidget {
  const EditItemBody({
    super.key,
    required this.state,
    required this.amountController,
  });

  final EditItemLoaded state;
  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditItemCubit>();
    final l10n = AppLocalizations.of(context);
    final isAdd = state.mode == AdjustMode.add;
    final whereTitle = isAdd ? l10n.whereFrom : l10n.whereDoesItGo;
    final moveTitle = isAdd ? l10n.moveFromBalance : l10n.moveToBalance;
    final moveSubtitle =
        isAdd ? l10n.moveFromBalanceSubtitle : l10n.moveToBalanceSubtitle;
    final helper = isAdd ? l10n.helperAdd : l10n.helperSubtract;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: [
        ActiveRecordCard(
          name: state.source.name,
          amountText: state.sourceAmountText,
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l10n.adjustAmount.toUpperCase(), style: AppTypography.fieldLabel),
            AdjustModeToggle(mode: state.mode, onChanged: cubit.setMode),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        TransferAmountField(
          controller: amountController,
          symbol: state.symbol,
          onChanged: cubit.setAmount,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(helper, style: AppTypography.itemNote),
        const SizedBox(height: AppSpacing.xl),
        Text(whereTitle, style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.lg),
        DestinationOption(
          title: moveTitle,
          subtitle: moveSubtitle,
          selected: state.destination == TransferDestination.moveToBalance,
          onTap: () => cubit.setDestination(TransferDestination.moveToBalance),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (isAdd ? l10n.sourceWallet : l10n.targetWallet).toUpperCase(),
                style: AppTypography.fieldLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              if (state.wallets.isEmpty)
                Text(l10n.noWallets, style: AppTypography.itemNote)
              else
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final wallet in state.wallets)
                      WalletChip(
                        label: wallet.name,
                        selected: wallet.id == state.targetWalletId,
                        onTap: () => cubit.setTargetWallet(wallet.id),
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (!isAdd) ...[
          const SizedBox(height: AppSpacing.lg),
          DestinationOption(
            title: l10n.forgivenTitle,
            subtitle: l10n.forgivenSubtitle,
            selected: state.destination == TransferDestination.forgiven,
            onTap: () => cubit.setDestination(TransferDestination.forgiven),
          ),
        ],
      ],
    );
  }
}
