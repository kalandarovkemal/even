import 'package:equatable/equatable.dart';

import '../dashboard/dashboard_view_data.dart';
import 'category_sort.dart';

sealed class CategoryDetailState extends Equatable {
  const CategoryDetailState();

  @override
  List<Object?> get props => [];
}

class CategoryDetailLoading extends CategoryDetailState {
  const CategoryDetailLoading();
}

class CategoryDetailLoaded extends CategoryDetailState {
  const CategoryDetailLoaded({
    required this.headerTotal,
    required this.headerNegative,
    required this.rows,
    required this.sort,
  });

  final String headerTotal;
  final bool headerNegative;
  final List<LedgerRowVm> rows;
  final CategorySort sort;

  @override
  List<Object?> get props => [headerTotal, headerNegative, rows, sort];
}

class CategoryDetailFailure extends CategoryDetailState {
  const CategoryDetailFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
