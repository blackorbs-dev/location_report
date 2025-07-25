import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared/domain/models/report.dart';
import '../../shared/domain/repository/report_repository.dart';

part 'report_search_event.dart';
part 'report_search_state.dart';

class ReportSearchBloc extends Bloc<ReportSearchEvent, ReportSearchState> {
  final ReportRepository _repository;

  ReportSearchBloc(this._repository) : super(ReportSearchState.initial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged, transformer: debounce());
  }

  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<ReportSearchState> emit) {
    if(event.query.isEmpty){
      emit(ReportSearchState.initial());
      return;
    }
    emit(ReportSearchState.loaded(_repository.searchReports(event.query)));
  }

  EventTransformer<T> debounce<T>({Duration duration = const Duration(milliseconds: 300)}) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
