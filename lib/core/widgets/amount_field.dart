import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    required this.symbol,
    required this.currencyCode,
    required this.onChanged,
    required this.onCurrencyTap,
  });

  final TextEditingController controller;
  final String symbol;
  final String currencyCode;
  final ValueChanged<String> onChanged;
  final VoidCallback onCurrencyTap;

  @override
  Widget build(BuildContext context) {
    final amountStyle = AppTypography.heroTotal.copyWith(
      color: AppColors.textPrimary,
      letterSpacing: 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(symbol, style: amountStyle.copyWith(color: AppColors.textMuted)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                style: amountStyle,
                cursorColor: AppColors.accent,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: '0.00',
                  hintStyle: amountStyle.copyWith(color: AppColors.textMuted),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: onCurrencyTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currencyCode, style: AppTypography.itemName),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const Divider(color: AppColors.divider, height: 1),
      ],
    );
  }
}
