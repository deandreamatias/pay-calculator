import 'package:flutter/material.dart';

import 'package:pay_calculator/util/database.dart';
import 'package:pay_calculator/util/format_time.dart';

class ReportModel {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectTimeInit = TimeOfDay.now();
  TimeOfDay selectTimeFinal = TimeOfDay.now();
  FormatTime formatTime = FormatTime();
  ReportElement reportElement = ReportElement();
  DatabaseHelper _databaseHelper = DatabaseHelper();

  void _reportBuild() {
    reportElement.date = formatTime.dateToString(selectedDate);
    print('Date: ${reportElement.date}');
    reportElement.initHour = formatTime.timeToString(selectTimeInit);
    print('Initial hour: ${reportElement.initHour}');
    reportElement.finalHour = formatTime.timeToString(selectTimeFinal);
    print('Final hour: ${reportElement.finalHour}');
    reportElement.money = _calcMoney();
    print('Money: ${reportElement.money}');
  }

  double _calcMoney() {
    final timeInit = formatTime.formatTime(selectedDate, selectTimeInit);
    final timeFinal = formatTime.formatTime(selectedDate, selectTimeFinal);

    int timeWork = timeInit.difference(timeFinal).inMinutes.abs();
    if (timeWork <= 390) {
      return 30.0;
    } else if (timeWork > 390 && timeWork < 420) {
      return 33.5;
    } else if (timeWork > 420 && timeWork < 450) {
      return 37.0;
    } else {
      return 0.0;
    }
  }

  void insertElement() {
    _reportBuild();
    _databaseHelper.insert(reportElement).then((value) {
      print('Insert element ${reportElement.toString()}');
    });
  }
}
