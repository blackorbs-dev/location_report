import '../../domain/models/report.dart';
import '../../domain/repository/report_repository.dart';
import '../database/database.dart';
import '../mappers/report_mapper.dart';

class ReportRepositoryImpl extends ReportRepository{
  final ReportDatabase _database;

  ReportRepositoryImpl(this._database);

  @override
  bool delete(int reportId) => _database.delete(reportId);

  @override
  Report? getReport(int id) => _database.getReport(id)?.toReport();

  @override
  Stream<List<Report>> getRecentReports() =>
      _database.getRecentReports()
      .map((list) =>
        list.map((e) => e.toReport()).toList()
      );

  @override
  int insert(Report report) => _database.insert(report.toEntity());

  @override
  Stream<List<Report>> reportsStream() {
    return _database.reportsStream()
        .map((reports) => reports.map((e) => e.toReport()).toList());
  }

  @override
  List<Report> searchReports(String query) {
    return _database.searchReports(query)
        .map((e) => e.toReport()).toList();
  }

  @override
  void dispose() {
    _database.close();
  }

}