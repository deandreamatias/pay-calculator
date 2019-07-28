import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatTime {
  String dateToString(DateTime date) {
    return DateFormat("dd/MM").format(date);
  }

  String timeToString(TimeOfDay time) {
    return time.hour.toString() + ":" + time.minute.toString();
  }

  DateTime formatTime(DateTime dateTime, TimeOfDay timeOfDay) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute);
  }
}
