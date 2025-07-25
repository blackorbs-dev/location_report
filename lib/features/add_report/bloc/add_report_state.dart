part of 'add_report_bloc.dart';

final class AddReportState extends Equatable {
  const AddReportState({
    this.reportType,
    this.errorMessage,
    this.location,
    this.description = '',
    this.isLoading = false,
    this.isValid = false,
    this.isDeleted = false,
    this.reportEdit,
    this.attachments = const [],
  });

  final ReportType? reportType;
  final String? errorMessage;
  final LocationModel? location;
  final String description;
  final List<String> attachments;
  final bool isLoading;
  final bool isValid;
  final bool isDeleted;
  final Report? reportEdit;

  AddReportState copyWith({
    ReportType? reportType,
    String? errorMessage,
    LocationModel? location,
    bool? isLoading,
    bool? isValid,
    bool? isDeleted,
    String? description,
    Report? reportEdit,
    List<String>? attachments,
  }){
    return AddReportState(
      reportEdit: reportEdit ?? this.reportEdit,
      reportType: reportType ?? this.reportType,
      errorMessage: errorMessage ?? this.errorMessage,
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      isValid: isValid ?? this.isValid,
      isDeleted: isDeleted ?? this.isDeleted,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
    );
  }


  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    reportType, errorMessage,
    location, isLoading,
    isValid, isDeleted,
    description, reportEdit,
    attachments
  ];

}
