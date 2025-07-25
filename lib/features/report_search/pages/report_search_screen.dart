import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/shared/presentation/widgets/app_bar.dart';
import 'package:location_report/features/shared/presentation/widgets/svg_icon.dart';

import '../../report_list/pages/report_list_box.dart';
import '../../shared/presentation/widgets/empty_list.dart';
import '../bloc/report_search_bloc.dart';

class ReportSearchScreen extends StatelessWidget{
  const ReportSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportSearchBloc(context.read()),
      child: const ReportSearchView(),
    );
  }

}

class ReportSearchView extends StatelessWidget{
  const ReportSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          title: 'Search Reports',
          action: CloseButton()
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBar(
              hintText: 'Enter a search term',
              hintStyle: WidgetStateProperty.all(
                context.theme.textTheme.bodySmall
                    .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
              ),
              textStyle: WidgetStateProperty.all(context.theme.textTheme.bodySmall),
              elevation: WidgetStateProperty.all(0),
              leading: SvgIcon('assets/icons/search.svg'),
              padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
              onChanged: (query){
                context.read<ReportSearchBloc>().add(SearchQueryChanged(query));
              },
            ),
            const SizedBox(height: 26),
            BlocBuilder<ReportSearchBloc, ReportSearchState>(
                builder: (context, state){
                  switch(state){
                    case Initial():
                      return const SizedBox();
                    case Loaded(:final reports):
                      return reports.isEmpty ? const EmptyListBox(text: 'No reports found')
                          : ReportListBox(reports: reports);
                  }
                },
            )
          ],
        ),
      ),
    );
  }

}