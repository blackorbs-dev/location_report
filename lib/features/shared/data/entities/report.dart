import 'package:objectbox/objectbox.dart';

import '../../domain/models/report_status.dart';
import '../../domain/models/report_type.dart';
import 'location.dart';

@Entity()
class ReportEntity{
  @Id()
  int id;

  String description;
  List<String> attachments;

  int? dbStatus; // stores enum as int
  int? dbType;

  @Property(type: PropertyType.date)
  DateTime date;

  final location = ToOne<LocationEntity>();

  @Transient()
  ReportStatus? get status => dbStatus == null ? null : ReportStatus.values[dbStatus!];
  set status(ReportStatus? value) => dbStatus = value?.index;

  @Transient()
  ReportType? get type => dbType == null ? null : ReportType.values[dbType!];
  set type(ReportType? value) => dbType = value?.index;

  ReportEntity({
    required this.id,
    required this.description,
    required this.date,
    required this.attachments,
    ReportStatus? status,
    ReportType? type,
  }) {
    this.status = status;
    this.type = type;
  }

}