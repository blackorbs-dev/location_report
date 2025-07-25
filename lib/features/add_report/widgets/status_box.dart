import 'package:flutter/cupertino.dart';
import 'package:location_report/core/util/formatter.dart';
import 'package:location_report/features/add_report/widgets/info_text.dart';

import '../../shared/domain/models/report_status.dart';

class StatusBox extends StatelessWidget{
  const StatusBox({super.key, required this.status, required this.date});

  final ReportStatus status;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InfoText(
              text: status.name,
              title: 'Status'
          ),
          InfoText(
              text: date.toReadableDateTime,
              title: 'Date submitted',
              alignment: CrossAxisAlignment.end
          ),
        ],
      );
  }

}