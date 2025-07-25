import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/core/util/formatter.dart';

import '../../domain/models/report.dart';

class ReportCard extends StatelessWidget{
  const ReportCard({super.key, required this.report, required this.onTap});

  final Report report;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.type.name,
                    style: context.theme.textTheme.bodyMedium
                      .withColor(context.theme.colorScheme.tertiaryContainer),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    report.location.address,
                    style: context.theme.textTheme.labelLarge
                        .withColor(context.theme.colorScheme.tertiaryContainer),
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      report.date.toReadableDateTime,
                      style: context.theme.textTheme.bodySmall
                          .withColor(context.theme.colorScheme.tertiaryContainer),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.status.name,
                      style: context.theme.textTheme.labelLarge
                          .withColor(context.theme.colorScheme.tertiary),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }

}