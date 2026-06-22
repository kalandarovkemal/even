import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/surface_card.dart';
import '../dashboard_view_data.dart';

class LedgerRowCard extends StatelessWidget {
  const LedgerRowCard({
    super.key,
    required this.row,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final LedgerRowVm row;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Slidable(
        key: ValueKey(row.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (_) => onEdit(),
              backgroundColor: AppColors.surfaceElevated,
              foregroundColor: AppColors.textPrimary,
              icon: Icons.edit_outlined,
            ),
            SlidableAction(
              onPressed: (_) => onDelete(),
              backgroundColor: AppColors.dangerMedium,
              foregroundColor: AppColors.danger,
              icon: Icons.delete_outline,
            ),
          ],
        ),
        child: SurfaceCard(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            row.name,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.itemName.copyWith(
                              color: row.informational
                                  ? AppColors.textMuted
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (row.informational) ...[
                          const SizedBox(width: AppSpacing.xs),
                          const Icon(
                            Icons.info_outline,
                            size: 14,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ],
                    ),
                    if (row.note != null && row.note!.isNotEmpty)
                      Text(row.note!, style: AppTypography.itemNote),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                row.amountText,
                style: AppTypography.amount.copyWith(
                  color: row.informational
                      ? AppColors.textMuted
                      : (row.negative ? AppColors.danger : AppColors.accent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
