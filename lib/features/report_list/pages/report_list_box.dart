import 'package:flutter/material.dart' hide Route;
import 'package:go_router/go_router.dart';

import '../../../router/routes.dart';
import '../../shared/domain/models/report.dart';
import '../../shared/presentation/widgets/report_card.dart';

class ReportListBox extends StatelessWidget{
  const ReportListBox({super.key, required this.reports});

  final List<Report> reports;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView.separated(
      padding: const EdgeInsets.only(top: 6, bottom: 66),
      itemCount: reports.length,
      separatorBuilder: (context, index){
        return const Divider();
      },
      itemBuilder: (context, index){
        final report = reports[index];
        return ReportCard(
            report: report,
            onTap: (){
              context.push(Route.reportDetailPath(report.id));
            }
        );
      },
    ));
  }

}