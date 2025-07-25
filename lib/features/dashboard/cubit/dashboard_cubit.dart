import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/domain/models/report.dart';
import '../../shared/domain/repository/report_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final ReportRepository _repository;
  StreamSubscription? _subscription;

  DashboardCubit(this._repository) : super(const DashboardState.initial()){
    _initialize();
  }

  void _initialize(){
    _subscription = _repository.getRecentReports().listen((data) =>
        emit(DashboardState.loaded(data))
    );
  }

  @override
  Future<void> close() async{
    await _subscription?.cancel();
    return super.close();
  }

}
