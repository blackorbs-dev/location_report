import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/shared/presentation/widgets/svg_icon.dart';

import '../../report_list/pages/report_list_box.dart';
import '../../shared/presentation/widgets/add_report_button.dart';
import '../../shared/presentation/widgets/app_bar.dart';
import '../../shared/presentation/widgets/empty_list.dart';
import '../cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DashboardCubit(context.read()),
        child: const DashboardView(),
    );
  }

}

class DashboardView extends StatelessWidget{
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Dashboard',
        leading: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgIcon('assets/icons/map_marker.svg')
        ),
      ),
      body: Center(
          child: Stack(
            children: [
              BlocBuilder<DashboardCubit, DashboardState>(
                  builder: (context, state){
                    switch(state){
                      case Initial():
                        return const CupertinoActivityIndicator();
                      case Loaded(:final recentReports):
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('My recent reports', style: context.theme.textTheme.titleMedium,),
                              if(recentReports.isEmpty)
                                const EmptyListBox()
                              else
                                ReportListBox(reports: recentReports)
                            ],
                          ),
                        );
                    }
                  }
              ),
              const AddReportButton(),
            ],
          )
      ),
    );
  }

}