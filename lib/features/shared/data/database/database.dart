import '../../../../generated/objectbox.g.dart';
import '../../domain/models/report_status.dart';
import '../../domain/models/report_type.dart';
import '../entities/report.dart';

class ReportDatabase{

  late final Store _store;
  late final Box<ReportEntity> _reportBox;
  late final Query<ReportEntity> _searchQuery;

  ReportDatabase._create(this._store){
    _reportBox = _store.box<ReportEntity>();
    _initSearchQuery();
  }

  static Future<ReportDatabase> create({Store? store}) async{
    return ReportDatabase._create(store ?? await openStore());
  }

  int insert(ReportEntity report) => _reportBox.put(report);

  bool delete(int reportId) => _reportBox.remove(reportId);

  ReportEntity? getReport(int id) => _reportBox.get(id);

  Stream<List<ReportEntity>> reportsStream() {
    return _reportBox.query()
        .order(ReportEntity_.date, flags: Order.descending)
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  Stream<List<ReportEntity>> getRecentReports() {
    final query = _reportBox.query()
      .order(ReportEntity_.date, flags: Order.descending);

    return query.watch(triggerImmediately: true)
        .map((query) => (query..limit = 10).find());
  }

  List<ReportEntity> searchReports(String query) {
    final q = query.trim().toLowerCase();

    _searchQuery..param(ReportEntity_.description, alias: 'desc').value = q
      ..param(ReportEntity_.dbStatus, alias: 'status').value = _statusIndexFromQuery(q)
      ..param(ReportEntity_.dbType, alias: 'type').value = _typeIndexFromQuery(q)
      ..param(ReportEntity_.date, alias: 'date').value = _dateFromQuery(q)?.millisecondsSinceEpoch ?? -1
      ..param(LocationEntity_.address, alias: 'addr').value = q;

    return _searchQuery.find();
  }


  void close() => _store.close();

  int _statusIndexFromQuery(String q) {
    for (final s in ReportStatus.values) {
      if (s.name.toLowerCase().contains(q)) return s.index;
    }
    return -1;
  }

  int _typeIndexFromQuery(String q) {
    for (final t in ReportType.values) {
      if (t.name.toLowerCase().contains(q)) return t.index;
    }
    return -1;
  }

  DateTime? _dateFromQuery(String q) {
    try {
      final parsed = DateTime.tryParse(q);
      if (parsed != null) return parsed;
    } catch (_) {}
    return null;
  }

  void _initSearchQuery() {
    final builder = _reportBox.query(
        ReportEntity_.description.contains('', caseSensitive: false, alias: 'desc')
            .or(ReportEntity_.dbStatus.equals(0, alias: 'status'))
            .or(ReportEntity_.dbType.equals(0, alias: 'type'))
            .or(ReportEntity_.date.equals(-1, alias: 'date'))
    );

    builder.link(
        ReportEntity_.location,
        LocationEntity_.address.contains('', caseSensitive: false, alias: 'addr')
    );

    _searchQuery = builder
        .order(ReportEntity_.date, flags: Order.descending)
        .build()..limit = 50;
  }


}