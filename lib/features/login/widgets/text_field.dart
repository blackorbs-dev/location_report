import 'package:flutter/material.dart';
import 'package:location_report/core/theme/extensions.dart';

import 'border.dart';

class TextInputField extends StatelessWidget{
  const TextInputField({super.key, required this.hint,  required this.onChanged, this.inputType, this.formKey, required this.validator,});

  final GlobalKey? formKey;
  final String hint;
  final TextInputType? inputType;
  final Function(String value) onChanged;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: formKey,
        style: context.theme.textTheme.bodySmall
            .withColor(context.theme.colorScheme.tertiaryContainer),
        keyboardType: inputType,
        validator: validator,
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: context.theme.textTheme.bodySmall
            .withColor(context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
          border: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
          enabledBorder: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
          focusedBorder: outlinedBorder(color: context.theme.colorScheme.tertiaryContainer.withValues(alpha: 0.6)),
          // contentPadding:
          //     const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        onChanged: onChanged
    );
  }

}