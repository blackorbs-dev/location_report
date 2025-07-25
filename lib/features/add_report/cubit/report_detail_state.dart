part of 'report_detail_cubit.dart';

sealed class ReportDetailState extends Equatable {
  const ReportDetailState();

  const factory ReportDetailState.initial() = Initial;
  const factory ReportDetailState.loaded(Report report) = Loaded;
}

final class Initial extends ReportDetailState {
  const Initial();

  @override
  List<Object> get props => [];
}

final class Loaded extends ReportDetailState{
  final Report report;
  const Loaded(this.report);

  @override
  List<Object?> get props => [report];

}
