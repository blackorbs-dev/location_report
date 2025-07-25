part of 'report_search_bloc.dart';

sealed class ReportSearchEvent extends Equatable {
  const ReportSearchEvent();
}

class SearchQueryChanged extends ReportSearchEvent {
  const SearchQueryChanged(this.query);
  final String query;

  @override
  List<Object?> get props => [query];

}
