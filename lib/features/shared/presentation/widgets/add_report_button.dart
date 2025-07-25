import 'package:flutter/material.dart' hide Route;
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:location_report/core/theme/extensions.dart';

import '../../../../router/routes.dart';

class AddReportButton extends StatelessWidget{
  const AddReportButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: FilledButton(
                onPressed: onPressed ?? (){
                  context.go(Route.reportMap);
                },
                style: FilledButton.styleFrom(
                    textStyle: context.theme.textTheme.titleSmall,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: context.theme.colorScheme.secondary
                        ),
                        borderRadius: BorderRadius.circular(32)
                    ),
                    foregroundColor: context.theme.colorScheme.surface,
                    backgroundColor: context.theme.colorScheme.primary
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/plus_circle.svg'),
                    const SizedBox(width: 6,),
                    const Text('Add Report')
                  ],
                )
            )
        )
    );
  }

}