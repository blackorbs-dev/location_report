part of 'report_list_cubit.dart';

sealed class ReportListState extends Equatable {
  const ReportListState();

  const factory ReportListState.initial() = Initial;
  const factory ReportListState.loaded(List<Report> reports) = Loaded;
}

final class Initial extends ReportListState {
  const Initial();

  @override
  List<Object> get props => [];
}

final class Loaded extends ReportListState{
  final List<Report> reports;

  const Loaded(this.reports);

  @override
  List<Object?> get props => [reports];

}
