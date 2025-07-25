import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/domain/models/report.dart';
import '../../shared/domain/repository/report_repository.dart';

part 'report_list_state.dart';

class ReportListCubit extends Cubit<ReportListState> {
  final ReportRepository _repository;
  StreamSubscription? _subscription;

  ReportListCubit(this._repository) : super(const ReportListState.initial()){
    _initialize();
  }

  void _initialize() {
    _subscription = _repository.reportsStream().listen((data) =>
        emit(ReportListState.loaded(data))
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
