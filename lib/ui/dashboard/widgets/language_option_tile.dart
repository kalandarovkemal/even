import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/i18n/app_languages.dart';
import '../../../core/i18n/locale_cubit.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../paywall/paywall_sheet.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.language,
    required this.selected,
    required this.locked,
  });

  final AppLanguage language;
  final bool selected;
  final bool locked;

  void _onTap(BuildContext context) {
    if (locked) {
      PaywallSheet.show(context);
      return;
    }
    context.read<LocaleCubit>().setLanguage(language.code);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(language.endonym, style: AppTypography.itemName),
      trailing: selected
          ? const Icon(Icons.check_circle, color: AppColors.accent)
          : (locked
              ? const Icon(Icons.lock_outline,
                  color: AppColors.textMuted, size: 20)
              : null),
      onTap: () => _onTap(context),
    );
  }
}
