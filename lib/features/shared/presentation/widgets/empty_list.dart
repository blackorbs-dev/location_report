import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';

class EmptyListBox extends StatelessWidget{
  const EmptyListBox({super.key, this.text = 'No reports available'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Text(
              text, style: context.theme.textTheme.bodyLarge
                  .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6))
          )
      ),
    );
  }

}