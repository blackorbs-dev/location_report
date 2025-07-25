import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/add_report/bloc/add_report_bloc.dart';
import 'package:location_report/features/shared/presentation/widgets/primary_button.dart';

class DeleteReportScreen extends StatelessWidget{
  const DeleteReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColoredBox(
            color: context.theme.colorScheme.tertiaryContainer,
            child: BlocSelector<AddReportBloc, AddReportState, bool>(
                selector: (state) => state.isDeleted,
                builder: (context, isDeleted){
                  return AnimatedSwitcher(
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isDeleted ? 'Your report has been deleted.' : 'Are you sure?\nYou cannot undo this!',
                            textAlign: TextAlign.center,
                            style: context.theme.textTheme.headlineSmall
                              .withColor(context.theme.colorScheme.surface),
                          ),
                          const SizedBox(height: 28,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PrimaryButton(
                                text: isDeleted ? 'Continue':'Cancel',
                                onPressed: context.pop,
                                key: ValueKey('cancel_button'),
                              ),
                              if(!isDeleted)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  key: ValueKey('delete_button'),
                                  child: PrimaryButton(
                                    text: 'Delete Report',
                                    onPressed: (){
                                      context.read<AddReportBloc>().add(DeleteReport());
                                    },
                                    filled: false,
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                  );
                }
            ),
        ),
        Positioned(
            top: 16, right: 12,
            child: CloseButton(color: context.theme.colorScheme.surface,)
        )
      ],
    );
  }

}