part of 'report_search_bloc.dart';

sealed class ReportSearchState extends Equatable {
  const ReportSearchState();
  const factory ReportSearchState.initial() = Initial;
  const factory ReportSearchState.loaded(List<Report> reports) = Loaded;
}

final class Initial extends ReportSearchState {
  const Initial();

  @override
  List<Object> get props => [];
}

final class Loaded extends ReportSearchState {
  const Loaded(this.reports);
  final List<Report> reports;

  @override
  List<Object> get props => [reports];
}
