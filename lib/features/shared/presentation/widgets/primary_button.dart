import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';

class PrimaryButton extends StatelessWidget{
  const PrimaryButton({super.key, required this.text, required this.onPressed, this.enabled = true, this.filled = true});

  final String text;
  final bool enabled;
  final bool filled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: enabled ? onPressed : null,
        style: FilledButton.styleFrom(
          textStyle: context.theme.textTheme.titleSmall,
          fixedSize: Size.fromHeight(42),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: enabled ? context.theme.colorScheme.secondary
                    : context.theme.colorScheme.secondaryContainer
              ),
              borderRadius: BorderRadius.circular(24)
          ),
          foregroundColor: filled ? context.theme.colorScheme.onPrimary
              : context.theme.colorScheme.primary,
          backgroundColor: filled ? context.theme.colorScheme.primary
              : context.theme.colorScheme.primaryContainer,
          disabledForegroundColor: context.theme.colorScheme.secondaryContainer,
          disabledBackgroundColor: context.theme.colorScheme.primaryContainer,
        ),
        child: Text(text,)
    );
  }

}