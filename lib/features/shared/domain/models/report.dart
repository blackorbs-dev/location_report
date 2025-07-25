import 'package:equatable/equatable.dart';

import 'location.dart';
import 'report_status.dart';
import 'report_type.dart';

class Report extends Equatable{
  final int id;
  final ReportType type;
  final String description;
  final List<String> attachments;
  final DateTime date;
  final LocationModel location;
  final ReportStatus status;

  const Report({
    this.id = 0,
    required this.type,
    required this.description,
    required this.date,
    required this.location,
    required this.status,
    this.attachments = const [],
  });

  @override
  List<Object?> get props => [id, type, description, attachments, date, location, status];

  @override
  bool? get stringify => true;

}