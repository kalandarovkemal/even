import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_routes.dart';
import '../../../core/di/injector.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/amount_field.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../domain/repositories/currency_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../add_item_cubit.dart';
import '../add_item_state.dart';
import 'category_tabs.dart';
import 'funding_selector.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final CurrencyRepository _currencies = sl<CurrencyRepository>();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickCurrency() async {
    final cubit = context.read<AddItemCubit>();
    final picked =
        await AppRoutes.pickCurrency(context, selectedCode: cubit.state.currencyCode);
    if (picked != null) {
      cubit.setCurrency(picked.code);
    }
  }

  Future<void> _submit() async {
    final cubit = context.read<AddItemCubit>();
    final created = await cubit.submit();
    if (created && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddItemCubit>();
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: BlocBuilder<AddItemCubit, AddItemState>(
        builder: (context, state) {
          final symbol = _currencies.byCode(state.currencyCode)?.symbol ?? r'$';
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.addNewItem, style: AppTypography.sectionTitle),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: AppColors.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              CategoryTabs(
                selected: state.category,
                onChanged: cubit.setCategory,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(l10n.nameField.toUpperCase(), style: AppTypography.fieldLabel),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _nameController,
                hint: l10n.nameHint,
                onChanged: cubit.setName,
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(l10n.amountField.toUpperCase(), style: AppTypography.fieldLabel),
              const SizedBox(height: AppSpacing.md),
              AmountField(
                controller: _amountController,
                symbol: symbol,
                currencyCode: state.currencyCode,
                onChanged: cubit.setAmount,
                onCurrencyTap: _pickCurrency,
              ),
              if (state.needsFunding) ...[
                const SizedBox(height: AppSpacing.xl),
                FundingSelector(
                  category: state.category,
                  wallets: state.wallets,
                  selectedId: state.fundingWalletId,
                  onSelected: cubit.setFundingWallet,
                ),
              ],
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: l10n.addItem,
                icon: Icons.add,
                onPressed: state.canSubmit ? _submit : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
