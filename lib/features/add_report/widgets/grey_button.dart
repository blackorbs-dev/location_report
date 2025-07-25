import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';

class GreyButton extends StatelessWidget{
  const GreyButton({super.key, required this.text, this.onPressed, this.alignment, this.icon});

  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          textStyle: context.theme.textTheme.bodySmall,
          fixedSize: Size.fromHeight(42),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: context.theme.colorScheme.secondaryContainer
              ),
              borderRadius: BorderRadius.circular(8)
          ),
          foregroundColor: context.theme.colorScheme.tertiaryContainer,
          backgroundColor: context.theme.colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            if(icon != null) Padding(
              padding: const EdgeInsets.only(right: 8),
              child: icon!,
            ),
            Text(text),
          ],
        )
    );
  }

}