import 'package:flutter/cupertino.dart' hide Route;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/features/report_list/cubit/report_list_cubit.dart';

import '../../../router/routes.dart';
import '../../shared/presentation/widgets/add_report_button.dart';
import '../../shared/presentation/widgets/app_bar.dart';
import '../../shared/presentation/widgets/empty_list.dart';
import '../../shared/presentation/widgets/svg_icon.dart';
import 'report_list_box.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportListCubit(context.read()),
      child: const ReportListView(),
    );
  }

}

class ReportListView extends StatelessWidget{
  const ReportListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'My Reports',
        leading: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgIcon('assets/icons/map_marker.svg')
        ),
        action: IconButton(
          onPressed: (){
            context.push(Route.search);
          },
          icon: const SvgIcon('assets/icons/search.svg'),
        ),
      ),
      body: Stack(
          children: [
            BlocBuilder<ReportListCubit, ReportListState>(
                builder: (context, state){
                  switch(state){
                    case Initial():
                      return const CupertinoActivityIndicator();
                    case Loaded(:final reports):
                      return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              reports.isEmpty ? const EmptyListBox()
                                  : ReportListBox(reports: reports)
                            ],
                          )
                      );
                  }
                }
            ),
            const AddReportButton(),
          ]
      ),
    );
  }

}