import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/features/shared/domain/models/report.dart';
import 'package:location_report/features/shared/domain/repository/report_repository.dart';

part 'report_detail_state.dart';

class ReportDetailCubit extends Cubit<ReportDetailState> {
  final ReportRepository _repository;

  ReportDetailCubit(this._repository) : super(ReportDetailState.initial());

  void getReport(int id) {
    final report = _repository.getReport(id);
    if (report != null) {
      emit(ReportDetailState.loaded(report));
    }
  }
}
