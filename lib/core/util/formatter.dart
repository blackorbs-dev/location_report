import 'package:intl/intl.dart';

extension FormattedDateTime on DateTime {
  String get toReadableDateTime {
    final datePart = DateFormat('d MMM yyyy').format(this);        // e.g., 3 Jun 2024
    final timePart = DateFormat('h:mm a').format(this).toLowerCase(); // e.g., 8:04 pm
    return '$datePart, ($timePart)';
  }
}