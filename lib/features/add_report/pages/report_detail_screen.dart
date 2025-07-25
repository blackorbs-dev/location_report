import 'dart:io';

import 'package:flutter/cupertino.dart' hide Route;
import 'package:flutter/material.dart' hide Route;
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/add_report/bloc/add_report_bloc.dart';
import 'package:location_report/features/add_report/widgets/status_box.dart';
import 'package:location_report/features/login/widgets/input_title.dart';
import 'package:location_report/features/shared/presentation/widgets/app_bar.dart';

import '../../../router/routes.dart';
import '../cubit/report_detail_cubit.dart';

class ReportDetailScreen extends StatelessWidget{
  const ReportDetailScreen({super.key, required this.reportId});

  final int reportId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportDetailCubit(context.read())..getReport(reportId),
      child: const ReportDetailView(),
    );
  }

}

class ReportDetailView extends StatelessWidget{
  const ReportDetailView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MainAppBar(
        title: 'Report',
        leading: BackButton(onPressed: context.pop,),
        action: TextButton(
            onPressed: (){
              final state = context.read<ReportDetailCubit>().state;
              if(state case Loaded(:final report)){
                context.read<AddReportBloc>().add(SetEditReport(report));
                context.push(Route.addReport);
              }
            },
            child: Text('Edit')
        ),
      ),
      body: BlocBuilder<ReportDetailCubit, ReportDetailState>(
          builder: (context, state){
            switch(state){
              case Initial():
                return const Center(child: CupertinoActivityIndicator());
              case Loaded(:final report):
                return CustomScrollView(
                  slivers: [
                    SliverList.list(
                        children: [
                          Container(
                            color: context.theme.colorScheme.tertiaryContainer,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    report.type.name,
                                    style: context.theme.textTheme.titleMedium
                                        .withColor(context.theme.colorScheme.surface)
                                ),
                                const SizedBox(width: 36,),
                                Expanded(child: Text(
                                    report.location.address,
                                    textAlign: TextAlign.end,
                                    style: context.theme.textTheme.bodySmall
                                        .withColor(context.theme.colorScheme.surface)
                                ))
                              ],
                            ),
                          ),
                          Container(
                            color: context.theme.colorScheme.primaryContainer,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: StatusBox(
                                status: report.status,
                                date: report.date
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: InputTitle(text: 'Description')
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                                report.description,
                                style: context.theme.textTheme.bodySmall
                            ),
                          )
                        ],
                    ),
                    SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        sliver: SliverList.builder(
                            itemCount: report.attachments.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Image.file(File(report.attachments[index])),
                              );
                            }
                        ),
                    )
                  ],
                );
            }
          }
      ),
    );
  }

}