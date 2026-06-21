import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injector.dart';
import '../../domain/entities/entry_category.dart';
import 'category_detail_cubit.dart';
import 'category_detail_view.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key, required this.category});

  final EntryCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryDetailCubit>(
      create: (_) => CategoryDetailCubit(
        category: category,
        ledger: sl(),
        settings: sl(),
        ratesService: sl(),
        currencies: sl(),
      )..start(),
      child: CategoryDetailView(category: category),
    );
  }
}
