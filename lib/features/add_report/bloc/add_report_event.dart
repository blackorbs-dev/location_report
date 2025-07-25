part of 'add_report_bloc.dart';

sealed class AddReportEvent extends Equatable {
  const AddReportEvent();
}

class ReportTypeChanged extends AddReportEvent {
  final ReportType reportType;
  const ReportTypeChanged(this.reportType);

  @override
  List<Object?> get props => [reportType];
}

class LocationChanged extends AddReportEvent {
  final LocationModel? location;
  const LocationChanged(this.location);

  @override
  List<Object?> get props => [location];
}

class DescriptionChanged extends AddReportEvent {
  final String description;
  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class AddAttachment extends AddReportEvent {
  final bool isImage;
  const AddAttachment({required this.isImage});

  @override
  List<Object?> get props => [isImage];
}

class SubmitReport extends AddReportEvent {
  const SubmitReport();

  @override
  List<Object?> get props => [];
}

class DeleteReport extends AddReportEvent {
  const DeleteReport();

  @override
  List<Object?> get props => [];
}

class SetEditReport extends AddReportEvent{
  final Report report;
  const SetEditReport(this.report);

  @override
  List<Object?> get props => [report];

}

