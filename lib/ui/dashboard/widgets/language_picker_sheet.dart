import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/monetization.dart';
import '../../../core/i18n/app_languages.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../paywall/purchase_cubit.dart';
import 'language_option_tile.dart';

class LanguagePickerSheet extends StatelessWidget {
  const LanguagePickerSheet({super.key, required this.currentCode});

  final String currentCode;

  static Future<void> show(BuildContext context, String currentCode) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LanguagePickerSheet(currentCode: currentCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unlocked = context.watch<PurchaseCubit>().state.unlocked;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
      ),
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).language,
              style: AppTypography.sectionTitle,
            ),
            const SizedBox(height: AppSpacing.lg),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  for (final language in kSupportedLanguages)
                    LanguageOptionTile(
                      language: language,
                      selected: language.code == currentCode,
                      locked: !unlocked &&
                          !Monetization.isLanguageFree(language.code),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
