import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injector.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/repositories/settings_repository.dart';
import 'add_item_cubit.dart';
import 'widgets/add_item_form.dart';

class AddItemSheet extends StatelessWidget {
  const AddItemSheet({super.key, required this.initialCurrency});

  final String initialCurrency;

  static Future<void> show(BuildContext context) async {
    final currency = await sl<SettingsRepository>().displayCurrency();
    if (!context.mounted) {
      return;
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddItemSheet(initialCurrency: currency),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddItemCubit>(
      create: (_) => AddItemCubit(ledger: sl(), initialCurrency: initialCurrency),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
        ),
        padding: EdgeInsets.only(
          left: AppSpacing.screenPadding,
          right: AppSpacing.screenPadding,
          top: AppSpacing.xl,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
        ),
        child: const AddItemForm(),
      ),
    );
  }
}
