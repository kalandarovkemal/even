import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class TransferAmountField extends StatelessWidget {
  const TransferAmountField({
    super.key,
    required this.controller,
    required this.symbol,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String symbol;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = AppTypography.heroTotal.copyWith(
      color: AppColors.textPrimary,
      letterSpacing: 0,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(symbol, style: style.copyWith(color: AppColors.textMuted)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                autofocus: true,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                style: style,
                cursorColor: AppColors.accent,
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: '0',
                  hintStyle: style.copyWith(color: AppColors.textMuted),
                  border: InputBorder.none,
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
