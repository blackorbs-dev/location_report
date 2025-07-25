import 'package:flutter/cupertino.dart';
import 'package:location_report/core/theme/extensions.dart';

class InfoText extends StatelessWidget{
  const InfoText({super.key, required this.text, required this.title, this.alignment = CrossAxisAlignment.start});

  final String text;
  final String title;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(title, style: context.theme.textTheme.titleSmall),
        const SizedBox(height: 4,),
        Text(text, style: context.theme.textTheme.bodySmall),
      ],
    );
  }

}