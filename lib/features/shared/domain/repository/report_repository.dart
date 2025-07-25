import '../models/report.dart';

abstract class ReportRepository{

  int insert(Report report);
  bool delete(int reportId);
  Report? getReport(int id);
  Stream<List<Report>> reportsStream();
  Stream<List<Report>> getRecentReports();
  List<Report> searchReports(String query);
  void dispose();

}