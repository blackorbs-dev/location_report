import 'package:flutter/material.dart';

extension ThemeProvider on BuildContext{
  //usage context.theme
  ThemeData get theme => Theme.of(this);
}

extension X on TextStyle? {
  TextStyle? withColor(Color? color) => this?.copyWith(color: color);
}