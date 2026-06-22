import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/entry_category.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/wallet_chip.dart';
import '../../common/wallet_option.dart';

class FundingSelector extends StatelessWidget {
  const FundingSelector({
    super.key,
    required this.category,
    required this.wallets,
    required this.selectedId,
    required this.onSelected,
  });

  final EntryCategory category;
  final List<WalletOption> wallets;
  final String? selectedId;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLent = category == EntryCategory.lent;
    final title = isLent ? l10n.fundFromWallet : l10n.fundToWallet;
    final noneLabel = isLent ? l10n.notFromBalance : l10n.notToBalance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: AppTypography.fieldLabel),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final wallet in wallets)
              WalletChip(
                label: wallet.name,
                selected: wallet.id == selectedId,
                onTap: () => onSelected(wallet.id),
              ),
            WalletChip(
              label: noneLabel,
              selected: selectedId == null,
              onTap: () => onSelected(null),
            ),
          ],
        ),
        if (selectedId == null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.informationalHint, style: AppTypography.itemNote),
        ],
      ],
    );
  }
}
