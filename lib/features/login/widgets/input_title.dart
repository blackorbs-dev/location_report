import 'package:flutter/cupertino.dart';
import 'package:location_report/core/theme/extensions.dart';

class InputTitle extends StatelessWidget{
  const InputTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 6),
        child: Text(
            text,
            style: context.theme.textTheme.bodySmall
              .withColor(context.theme.colorScheme.tertiaryContainer),
        ),
    );
  }

}