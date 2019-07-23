import 'package:flutter/material.dart';

import 'package:pay_calculator/util/database.dart';
import 'package:pay_calculator/util/format_time.dart';
import 'package:scoped_model/scoped_model.dart';

class ReportModel extends Model {
  FormatTime formatTime = FormatTime();
  ReportElement reportElement = ReportElement();
  Database _database = Database();
  DateTime selectInitDate = DateTime.now().subtract(Duration(hours: 6));
  DateTime selectFinalDate = DateTime.now();
  TimeOfDay selectInitTime = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay selectFinalTime = TimeOfDay.now();
  int money = 30;
  int moneyExtra = 7;

  /// Public method of report model
  updateDate(DateTime date, bool initDate) {
    initDate ? selectInitDate = date : selectFinalDate = date;
    notifyListeners();
  }

  updateTime(TimeOfDay time, bool initHour) {
    initHour ? selectInitTime = time : selectFinalTime = time;
    notifyListeners();
  }

  insertElement() {
    _reportBuild();
    _database.insert(reportElement);
    _database.queryList().then((list) {
      print('Query ready');
    });
    notifyListeners();
  }

  // Private method to build report element
  _reportBuild() {
    reportElement.id = 1;
    reportElement.initDate = formatTime.dateToString(selectInitDate);
    print('Date: ${reportElement.initDate}');
    reportElement.finalDate = formatTime.dateToString(selectFinalDate);
    print('Date: ${reportElement.finalDate}');
    reportElement.initHour = formatTime.timeToString(selectInitTime);
    print('Initial hour: ${reportElement.initHour}');
    reportElement.finalHour = formatTime.timeToString(selectFinalTime);
    print('Final hour: ${reportElement.finalHour}');
    reportElement.money = _calcMoney();
    print('Money: ${reportElement.money}');
  }

  int _calcMoney() {
    final timeInit = formatTime.formatTime(selectInitDate, selectInitTime);
    final timeFinal = formatTime.formatTime(selectFinalDate, selectFinalTime);

    int timeWork = timeInit.difference(timeFinal).inMinutes.abs();
    if (timeWork <= 390) {
      return money;
    } else if (timeWork > 390 && timeWork <= 420) {
      return 33;
    } else if (timeWork > 420 && timeWork <= 450) {
      return money+moneyExtra;
    } else if (timeWork > 450 && timeWork <= 480) {
      return money+10;
    } else {
      return 0;
    }
  }

  static ReportModel of(BuildContext context) =>
      ScopedModel.of<ReportModel>(context);
}

class ReportElement {
  int id;
  String initDate;
  String finalDate;
  String initHour;
  String finalHour;
  int money;

  ReportElement(
      {this.initDate, this.finalDate, this.initHour, this.finalHour, this.money, this.id});
}
