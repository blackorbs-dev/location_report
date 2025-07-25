import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/features/add_report/bloc/add_report_bloc.dart';
import 'package:location_report/features/add_report/pages/add_report_screen.dart';
import 'package:location_report/features/add_report/pages/delete_report_screen.dart';
import 'package:location_report/features/add_report/pages/report_detail_screen.dart';
import 'package:location_report/features/report_map/pages/report_map_screen.dart';
import 'package:location_report/features/shared/domain/models/location.dart';
import 'package:path/path.dart';

import '../features/dashboard/pages/dashboard_screen.dart';
import '../features/login/pages/login.dart';
import '../features/report_list/pages/report_list_screen.dart';
import '../features/report_search/pages/report_search_screen.dart';
import '../features/shared/presentation/pages/home_screen.dart';
import 'transition_builders.dart';
import 'routes.dart';

final router = GoRouter(
    initialLocation: Route.login,
    routes: [
      GoRoute(
          path: Route.login,
          builder: (context, state) => LoginScreen()
      ),
      ShellRoute(
          pageBuilder: (context, state, child){
            final location = state.extra as LocationModel?;
            return slideTransition(
                key: state.pageKey,
                child: BlocProvider(
                  create: (_) => AddReportBloc(context.read())
                    ..add(LocationChanged(location)),
                  child: child,
                )
            );
          },
          routes: [
            GoRoute(
                path: Route.addReport,
                pageBuilder: (context, state) =>
                    slideTransition(
                        key: state.pageKey,
                        child: const AddReportScreen()
                    )
            ),
            GoRoute(
                path: Route.reportDetail,
                pageBuilder: (context, state){
                  final id = int.parse(state.pathParameters['id']!);
                  return slideTransition(
                      key: state.pageKey,
                      child: ReportDetailScreen(reportId: id)
                  );
                }
            ),
            GoRoute(
                path: Route.deleteReport,
                pageBuilder: (context, state) =>
                    slideTransition(
                        key: state.pageKey,
                        child: const DeleteReportScreen()
                    ),
            ),
          ]
      ),
      GoRoute(
          path: Route.search,
          pageBuilder: (context, state) =>
              slideTransition(
                key: state.pageKey,
                child: const ReportSearchScreen(),
              )
      ),
      ShellRoute(
          pageBuilder: (context, state, child) =>
              slideTransition(
                key: state.pageKey,
                child: HomeScreen(child: child),
              ),
          routes: [
            GoRoute(
                path: Route.dashboard,
                pageBuilder: (context, state) =>
                    fadeTransition(
                      key: state.pageKey,
                      child: const DashboardScreen(),
                    )
            ),
            GoRoute(
                path: Route.reportList,
                pageBuilder: (context, state) =>
                    fadeTransition(
                      key: state.pageKey,
                      child: const ReportListScreen(),
                    )
            ),
            GoRoute(
                path: Route.reportMap,
                pageBuilder: (context, state) =>
                    fadeTransition(
                      key: state.pageKey,
                      child: const ReportMapScreen(),
                    )
            ),
          ]
      )
    ]
);