import 'package:equatable/equatable.dart';

import 'dashboard_view_data.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.data);

  final DashboardViewData data;

  @override
  List<Object?> get props => [data];
}

class DashboardFailure extends DashboardState {
  const DashboardFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
