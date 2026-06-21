import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DashboardFab extends StatelessWidget {
  const DashboardFab({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.background,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 24),
    );
  }
}
