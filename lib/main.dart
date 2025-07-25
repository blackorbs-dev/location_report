import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/theme/type.dart';
import 'package:location_report/features/shared/data/database/database.dart';
import 'package:location_report/features/shared/data/repository/report_repository_impl.dart';
import 'package:location_report/features/shared/domain/repository/report_repository.dart';
import 'package:location_report/router/router.dart';

import 'core/theme/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final database = await ReportDatabase.create();

  runApp(
    RepositoryProvider<ReportRepository>(
        create: (context) => ReportRepositoryImpl(database),
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Location Report',
      theme: ThemeData(
        fontFamily: 'Rubik',
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.secondary,
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            secondary: AppColors.secondary,
            tertiary: AppColors.tertiary,
            primaryContainer: AppColors.primaryContainer,
            secondaryContainer: AppColors.secondaryContainer,
            tertiaryContainer: AppColors.tertiaryContainer,
            surface: AppColors.surface,
            onSurface: AppColors.onSurface
        ),
        useMaterial3: true,
        textTheme: textTheme
      ),
      routerConfig: router,
    );
  }
}
