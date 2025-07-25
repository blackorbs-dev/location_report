part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState extends Equatable {
  const DashboardState();

  const factory DashboardState.initial() = Initial;
  const factory DashboardState.loaded(List<Report> recentReports) = Loaded;
}

final class Initial extends DashboardState {
  const Initial();

  @override
  List<Object> get props => [];
}

final class Loaded extends DashboardState{
  final List<Report> recentReports;

  const Loaded(this.recentReports);

  @override
  List<Object?> get props => [recentReports];

}
