import 'package:flutter/material.dart';

import '../../../app/app_routes.dart';
import '../../../core/di/injector.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../domain/repositories/ledger_repository.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../common/delete_confirm_dialog.dart';
import '../dashboard_view_data.dart';
import 'hero_total.dart';
import 'language_selector.dart';
import 'portfolio_section.dart';
import 'stale_rates_note.dart';
import 'unlock_button.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key, required this.data});

  final DashboardViewData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.xl,
        AppSpacing.screenPadding,
        96,
      ),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UnlockButton(),
            LanguageSelector(),
          ],
        ),
        HeroTotal(
          totalText: data.totalText,
          totalNegative: data.totalNegative,
          displayCode: data.displayCode,
          onCurrencyTap: () => _onCurrencyTap(context),
        ),
        if (data.ratesStale) const StaleRatesNote(),
        const SizedBox(height: AppSpacing.xxl),
        for (final section in data.sections) ...[
          PortfolioSection(
            section: section,
            onViewAll: () => AppRoutes.openCategory(context, section.category),
            onRowTap: (id) => AppRoutes.openEditItem(context, id),
            onRowEdit: (id) => AppRoutes.openEditItem(context, id),
            onRowDelete: (id) => _onDelete(context, id),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ],
    );
  }

  Future<void> _onCurrencyTap(BuildContext context) async {
    final picked =
        await AppRoutes.pickCurrency(context, selectedCode: data.displayCode);
    if (picked == null) {
      return;
    }
    await sl<SettingsRepository>().setDisplayCurrency(picked.code);
  }

  Future<void> _onDelete(BuildContext context, String id) async {
    final confirmed = await DeleteConfirmDialog.show(context);
    if (!confirmed) {
      return;
    }
    await sl<LedgerRepository>().delete(id);
  }
}
