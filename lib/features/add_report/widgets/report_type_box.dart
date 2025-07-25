import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/theme/extensions.dart';

import '../../shared/domain/models/report_type.dart';
import '../../shared/presentation/widgets/svg_icon.dart';
import '../bloc/add_report_bloc.dart';

class ReportTypeBox extends StatelessWidget{
  const ReportTypeBox({super.key, required this.reportType, required this.isSelected});

  final ReportType reportType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<AddReportBloc>().add(ReportTypeChanged(reportType));
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(right: 6),
          constraints: const BoxConstraints(maxWidth: 90, minHeight: 100),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? context.theme.colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              SvgIcon(reportType.icon, size: 40,),
              const SizedBox(height: 4,),
              Text(
                reportType.name, textAlign: TextAlign.center,
                style: context.theme.textTheme.labelLarge
                    .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.7)),
              ),
            ],
          )
      )
    );
  }
}