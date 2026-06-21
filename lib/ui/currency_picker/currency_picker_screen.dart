import 'package:flutter/material.dart';

import '../../core/di/injector.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/currency.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/currency_list_tile.dart';
import 'widgets/currency_search_field.dart';
import 'widgets/recent_currency_chip.dart';

class CurrencyPickerScreen extends StatefulWidget {
  const CurrencyPickerScreen({super.key, required this.selectedCode});

  final String selectedCode;

  @override
  State<CurrencyPickerScreen> createState() => _CurrencyPickerScreenState();
}

class _CurrencyPickerScreenState extends State<CurrencyPickerScreen> {
  final TextEditingController _controller = TextEditingController();
  final CurrencyRepository _currencies = sl<CurrencyRepository>();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _select(Currency currency) async {
    await _currencies.markUsed(currency.code);
    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(currency);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final results =
        _query.isEmpty ? _currencies.all() : _currencies.search(_query);
    final recents = _currencies.recent();
    final showRecent = _query.isEmpty && recents.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectCurrency), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.sm),
              CurrencySearchField(
                controller: _controller,
                hint: l10n.searchCurrencyHint,
                onChanged: (value) => setState(() => _query = value),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (showRecent) ...[
                Text(l10n.recent.toUpperCase(), style: AppTypography.fieldLabel),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: [
                    for (final currency in recents)
                      RecentCurrencyChip(
                        code: currency.code,
                        selected: currency.code == widget.selectedCode,
                        onTap: () => _select(currency),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
              Text(
                (_query.isEmpty ? l10n.allCurrencies : l10n.results)
                    .toUpperCase(),
                style: AppTypography.fieldLabel,
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  itemCount: results.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final currency = results[index];
                    return CurrencyListTile(
                      currency: currency,
                      selected: currency.code == widget.selectedCode,
                      onTap: () => _select(currency),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
