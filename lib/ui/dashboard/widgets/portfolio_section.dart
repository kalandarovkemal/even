import 'package:flutter/material.dart';

import '../../../core/i18n/category_l10n.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/category_palette.dart';
import '../../../core/widgets/pill_badge.dart';
import '../../../domain/entities/entry_category.dart';
import '../../../l10n/app_localizations.dart';
import '../dashboard_view_data.dart';
import 'ledger_row_card.dart';
import 'subtotal_line.dart';
import 'view_all_button.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({
    super.key,
    required this.section,
    required this.onViewAll,
    required this.onRowTap,
    required this.onRowEdit,
    required this.onRowDelete,
  });

  final SectionVm section;
  final VoidCallback onViewAll;
  final ValueChanged<String> onRowTap;
  final ValueChanged<String> onRowEdit;
  final ValueChanged<String> onRowDelete;

  @override
  Widget build(BuildContext context) {
    final palette = CategoryPalette.of(section.category);
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.categoryTitle(section.category),
              style: AppTypography.sectionTitle,
            ),
            if (section.category == EntryCategory.balance)
              PillBadge(
                text: l10n.categoryBadge(section.category).toUpperCase(),
                foreground: palette.foreground,
                background: palette.background,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final row in section.rows) ...[
          LedgerRowCard(
            row: row,
            onTap: () => onRowTap(row.id),
            onEdit: () => onRowEdit(row.id),
            onDelete: () => onRowDelete(row.id),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (section.hasMore) ...[
          ViewAllButton(onTap: onViewAll),
          const SizedBox(height: AppSpacing.md),
        ],
        SubtotalLine(
          amountText: section.subtotalText,
          negative: section.negative,
        ),
      ],
    );
  }
}
