import 'package:flutter/material.dart';

InputBorder outlinedBorder({required Color color}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );