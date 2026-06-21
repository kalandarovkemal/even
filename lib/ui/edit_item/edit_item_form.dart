import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/primary_button.dart';
import '../../l10n/app_localizations.dart';
import 'edit_item_cubit.dart';
import 'edit_item_state.dart';
import 'widgets/edit_item_body.dart';

class EditItemForm extends StatefulWidget {
  const EditItemForm({super.key});

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final saved = await context.read<EditItemCubit>().save();
    if (saved && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(l10n.editItem),
      ),
      bottomNavigationBar: BlocBuilder<EditItemCubit, EditItemState>(
        builder: (context, state) {
          if (state is! EditItemLoaded) {
            return const SizedBox.shrink();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: PrimaryButton(
                label: l10n.saveTransfer,
                onPressed: state.canSave ? _save : null,
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: BlocBuilder<EditItemCubit, EditItemState>(
          builder: (context, state) => switch (state) {
            EditItemLoading() => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            EditItemNotFound() => Center(
                child: Text(l10n.itemNotFound, style: AppTypography.itemNote),
              ),
            EditItemLoaded() => EditItemBody(
                state: state,
                amountController: _amountController,
              ),
          },
        ),
      ),
    );
  }
}
