import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/error/extensions.dart';
import 'package:location_report/core/util/response.dart';
import 'package:location_report/features/shared/domain/models/location.dart';
import 'package:location_report/features/shared/domain/models/report.dart';
import 'package:location_report/features/shared/domain/models/report_type.dart';
import 'package:location_report/features/shared/domain/repository/report_repository.dart';

import '../../../core/util/media_picker.dart';
import '../../shared/domain/models/report_status.dart';

part 'add_report_event.dart';
part 'add_report_state.dart';

class AddReportBloc extends Bloc<AddReportEvent, AddReportState> {
  final ReportRepository _repository;

  AddReportBloc(this._repository) : super(AddReportState()) {
    on<AddAttachment>(_onAddAttachment);
    on<ReportTypeChanged>(_onReportTypeChanged);
    on<LocationChanged>(_onLocationChanged);
    on<SubmitReport>(_onSubmitReport);
    on<DeleteReport>(_onDeleteReport);
    on<SetEditReport>(_onSetEditReport);
    on<DescriptionChanged>(_onDescriptionChanged);
  }

  void _onSubmitReport(SubmitReport event, Emitter<AddReportState> emit) {
    if(state.isValid){
      _repository.insert(
        Report(
            type: state.reportType!,
            description: state.description,
            date: DateTime.now(),
            location: state.location!,
            status: ReportStatus.pending,
            attachments: state.attachments
        )
      );
    }
  }

  void _onDeleteReport(DeleteReport event, Emitter<AddReportState> emit) {
    _repository.delete(state.reportEdit!.id);
    emit(state.copyWith(isDeleted: true));
  }

  void _onDescriptionChanged(DescriptionChanged event, Emitter<AddReportState> emit) {
    emit(state.copyWith(
        description: event.description,
        isValid: event.description.isNotEmpty && state.reportType != null
    ));
  }

  void _onReportTypeChanged(ReportTypeChanged event, Emitter<AddReportState> emit) {
    emit(state.copyWith(
        reportType: event.reportType,
        isValid: state.description.isNotEmpty
    ));
  }

  void _onLocationChanged(LocationChanged event, Emitter<AddReportState> emit) {
    emit(state.copyWith(location: event.location));
  }

  void _onSetEditReport(SetEditReport event, Emitter<AddReportState> emit){
    emit(
      AddReportState(
        isValid: true,
        reportEdit: event.report,
        reportType: event.report.type,
        location: event.report.location,
        description: event.report.description,
        attachments: event.report.attachments
      )
    );
  }

  void _onAddAttachment(AddAttachment event, Emitter<AddReportState> emit) async {
    if(state.location == null){
      emit(state.copyWith(errorMessage: 'Please select a location first'));
      return;
    }
    emit(state.copyWith(isLoading: true));

    final response = await pickMediaWithOverlay(
      isImage: event.isImage,
      location: state.location!,
    );
    response.onSuccess((path) {
      emit(state.copyWith(
          attachments: [...state.attachments, path!],
          isLoading: false)
      );
    }).onError((error) {
      emit(state.copyWith(errorMessage: error.message(), isLoading: false));
    });
  }
}
