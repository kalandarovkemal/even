import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injector.dart';
import 'edit_item_cubit.dart';
import 'edit_item_form.dart';

class EditItemScreen extends StatelessWidget {
  const EditItemScreen({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditItemCubit>(
      create: (_) => EditItemCubit(
        entryId: entryId,
        ledger: sl(),
        ratesService: sl(),
        transferService: sl(),
        currencies: sl(),
      )..start(),
      child: const EditItemForm(),
    );
  }
}
