import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../add_item/add_item_sheet.dart';
import 'dashboard_cubit.dart';
import 'dashboard_state.dart';
import 'widgets/dashboard_content.dart';
import 'widgets/dashboard_fab.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: DashboardFab(
        onPressed: () => AddItemSheet.show(context),
      ),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) => switch (state) {
            DashboardLoading() => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
            DashboardFailure(:final message) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTypography.itemNote,
                  ),
                ),
              ),
            DashboardLoaded(:final data) => DashboardContent(data: data),
          },
        ),
      ),
    );
  }
}
