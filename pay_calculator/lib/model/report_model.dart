import 'package:flutter/material.dart';

import 'package:pay_calculator/util/database.dart';
import 'package:pay_calculator/util/format_time.dart';

class ReportModel {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectTimeInit = TimeOfDay.now();
  TimeOfDay selectTimeFinal = TimeOfDay.now();
  FormatTime formatTime = FormatTime();
  ReportElement reportElement = ReportElement();
  Database _database = Database();

  void _reportBuild() {
    reportElement.id = 1;
    reportElement.date = formatTime.dateToString(selectedDate);
    print('Date: ${reportElement.date}');
    reportElement.initHour = formatTime.timeToString(selectTimeInit);
    print('Initial hour: ${reportElement.initHour}');
    reportElement.finalHour = formatTime.timeToString(selectTimeFinal);
    print('Final hour: ${reportElement.finalHour}');
    reportElement.money = _calcMoney();
    print('Money: ${reportElement.money}');
  }

  int _calcMoney() {
    final timeInit = formatTime.formatTime(selectedDate, selectTimeInit);
    final timeFinal = formatTime.formatTime(selectedDate, selectTimeFinal);

    int timeWork = timeInit.difference(timeFinal).inMinutes.abs();
    if (timeWork <= 390) {
      return 30;
    } else if (timeWork > 390 && timeWork < 420) {
      return 33;
    } else if (timeWork > 420 && timeWork < 450) {
      return 37;
    } else {
      return 0;
    }
  }

  void insertElement() {
    _reportBuild();
    _database.insert(reportElement);
  }
}

class ReportElement  {
  int id;
  String date;
  String initHour;
  String finalHour;
  int money;

  ReportElement({this.date, this.initHour, this.finalHour, this.money, this.id});
}