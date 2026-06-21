import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class SubtotalLine extends StatelessWidget {
  const SubtotalLine({
    super.key,
    required this.amountText,
    this.negative = false,
  });

  final String amountText;
  final bool negative;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context).subtotal.toUpperCase(),
            style: AppTypography.subtotalLabel,
          ),
          Text(
            amountText,
            style: AppTypography.amount.copyWith(
              fontWeight: FontWeight.w700,
              color: negative ? AppColors.danger : AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
