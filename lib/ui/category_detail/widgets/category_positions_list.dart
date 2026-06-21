import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_routes.dart';
import '../../../core/di/injector.dart';
import '../../../core/i18n/category_l10n.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/repositories/ledger_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/delete_confirm_dialog.dart';
import '../../dashboard/widgets/ledger_row_card.dart';
import '../category_detail_cubit.dart';
import '../category_detail_state.dart';
import 'detail_header.dart';
import 'sort_menu_button.dart';

class CategoryPositionsList extends StatelessWidget {
  const CategoryPositionsList({super.key, required this.state});

  final CategoryDetailLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryDetailCubit>();
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.lg,
        AppSpacing.screenPadding,
        96,
      ),
      children: [
        DetailHeader(
          label: l10n.categoryTotalLabel(cubit.category).toUpperCase(),
          total: state.headerTotal,
          negative: state.headerNegative,
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.activePositions.toUpperCase(),
              style: AppTypography.fieldLabel,
            ),
            SortMenuButton(current: state.sort, onSelected: cubit.setSort),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        for (final row in state.rows) ...[
          LedgerRowCard(
            row: row,
            onTap: () => AppRoutes.openEditItem(context, row.id),
            onEdit: () => AppRoutes.openEditItem(context, row.id),
            onDelete: () => _onDelete(context, row.id),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }

  Future<void> _onDelete(BuildContext context, String id) async {
    final confirmed = await DeleteConfirmDialog.show(context);
    if (!confirmed) {
      return;
    }
    await sl<LedgerRepository>().delete(id);
  }
}
