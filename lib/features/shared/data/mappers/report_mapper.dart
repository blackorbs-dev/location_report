import '../../domain/models/report.dart';
import '../entities/report.dart';
import 'location_mapper.dart';

extension EntityToReport on ReportEntity{
  Report toReport() => Report(
    id: id,
    type: type!,
    description: description,
    attachments: attachments,
    date: date,
    location: location.target!.toLocation(),
    status: status!,
  );
}

extension ReportToEntity on Report{
  ReportEntity toEntity() => ReportEntity(
    id: id,
    type: type,
    description: description,
    attachments: attachments,
    date: date,
    status: status,
  )..location.target = location.toEntity();
}