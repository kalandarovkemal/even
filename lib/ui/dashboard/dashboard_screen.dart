import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injector.dart';
import 'dashboard_cubit.dart';
import 'dashboard_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (_) => DashboardCubit(
        ledger: sl(),
        settings: sl(),
        ratesService: sl(),
        calculator: sl(),
        currencies: sl(),
      )..start(),
      child: const DashboardView(),
    );
  }
}
