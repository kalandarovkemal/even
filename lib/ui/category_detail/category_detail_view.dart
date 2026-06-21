import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/i18n/category_l10n.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../domain/entities/entry_category.dart';
import '../../l10n/app_localizations.dart';
import '../add_item/add_item_sheet.dart';
import 'category_detail_cubit.dart';
import 'category_detail_state.dart';
import 'widgets/category_positions_list.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key, required this.category});

  final EntryCategory category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).categoryTitle(category)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemSheet.show(context),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
          builder: (context, state) => switch (state) {
            CategoryDetailLoading() => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            CategoryDetailFailure(:final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTypography.itemNote,
                  ),
                ),
              ),
            CategoryDetailLoaded() => CategoryPositionsList(state: state),
          },
        ),
      ),
    );
  }
}
