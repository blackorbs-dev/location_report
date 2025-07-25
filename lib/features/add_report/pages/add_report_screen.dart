import 'package:flutter/cupertino.dart' hide Route;
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/features/add_report/widgets/grey_button.dart';
import 'package:location_report/features/add_report/widgets/report_type_box.dart';
import 'package:location_report/features/add_report/widgets/status_box.dart';
import 'package:location_report/features/login/widgets/input_title.dart';
import 'package:location_report/features/shared/domain/models/report_type.dart';
import 'package:location_report/features/shared/presentation/widgets/app_bar.dart';
import 'package:location_report/features/shared/presentation/widgets/primary_button.dart';
import 'package:location_report/router/routes.dart';
import 'package:path/path.dart' as p;

import '../../login/widgets/border.dart';
import '../bloc/add_report_bloc.dart';

class AddReportScreen extends StatelessWidget{
  const AddReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(
        text: context.read<AddReportBloc>().state.description
    );

    return BlocBuilder<AddReportBloc, AddReportState>(
        builder: (context, state){
          final isEdit = state.reportEdit != null;

          return Scaffold(
              appBar: MainAppBar(
                title: '${isEdit ? 'Edit': 'Add'} Report',
                leading: isEdit ? BackButton() : null,
                action: isEdit ? TextButton(
                    onPressed: (){
                      context.push(Route.deleteReport);
                    },
                    child: Text('Delete')
                ) : CloseButton(onPressed: context.pop,),
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      SingleChildScrollView(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(isEdit)
                              ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: StatusBox(
                                      status: state.reportEdit!.status,
                                      date: state.reportEdit!.date
                                  ),
                                ),
                                const Divider(thickness: 1,height: 1,),
                              ],
                            InputTitle(text: 'What are you reporting?'),
                            SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: ReportType.values.map((type) =>
                                    ReportTypeBox(reportType: type, isSelected: state.reportType == type)
                                ).toList()
                            )),
                            Text(
                              'If answering ‘Other’, please provide details in the description.',
                              style: context.theme.textTheme.bodySmall
                                  .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
                            ),
                            InputTitle(text: 'Location'),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.primaryContainer,
                                border: Border.all(color: context.theme.colorScheme.secondaryContainer),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Text(
                                  state.location == null ? 'Select Location'
                                      : state.location!.address,
                                  style: context.theme.textTheme.bodySmall,
                              ),
                            ),
                            InputTitle(text: 'Description'),
                            TextField(
                              controller: textController,
                              onChanged: (value) => context.read<AddReportBloc>().add(DescriptionChanged(value)),
                              minLines: 5,
                              maxLines: 5,
                              style: context.theme.textTheme.bodySmall
                                  .withColor(context.theme.colorScheme.tertiaryContainer),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Enter a description...',
                                hintStyle: context.theme.textTheme.bodySmall
                                    .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
                                border: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
                                enabledBorder: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
                                focusedBorder: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
                              ),
                            ),
                            InputTitle(text: 'Photos/Videos (Optional)'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GreyButton(
                                  text: 'Add Photos',
                                  onPressed: (){
                                    context.read<AddReportBloc>().add(AddAttachment(isImage: true));
                                  },
                                  icon: Icon(Icons.attach_file),
                                ),
                                GreyButton(
                                  text: 'Add Videos',
                                  onPressed: (){
                                    context.read<AddReportBloc>().add(AddAttachment(isImage: false));
                                  },
                                  icon: Icon(Icons.attach_file),
                                )
                              ],
                            ),
                            ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 12, bottom: 76),
                                itemBuilder: (context, index){
                                  return Text(p.basename(state.attachments[index]), style: context.theme.textTheme.bodySmall);
                                },
                                separatorBuilder: (context,_) => Divider(),
                                itemCount: state.attachments.length
                            ),
                          ]
                      )),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PrimaryButton(
                                  text: 'Cancel',
                                  onPressed: context.pop,
                                  filled: false,
                                ),
                                PrimaryButton(
                                    text: 'Submit Report',
                                    enabled: state.isValid,
                                    onPressed: (){
                                      context.read<AddReportBloc>().add(const SubmitReport());
                                      Fluttertoast.showToast(msg: 'Report submitted successfully');
                                      context.pop();
                                    }
                                )
                              ],
                            )
                          )
                      ),
                      if(state.isLoading) Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100, height: 100,
                            decoration: BoxDecoration(
                              color: context.theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const CupertinoActivityIndicator(),
                          )
                      )
                    ],
                  )
              )
          );
        });
  }
}