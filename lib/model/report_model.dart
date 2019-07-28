import 'package:flutter/material.dart';
import 'package:pay_calculator/util/files_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:pay_calculator/util/database.dart';
import 'package:pay_calculator/util/format_time.dart';

class ReportModel extends Model {
  FormatTime formatTime = FormatTime();
  ReportElement reportElement = ReportElement();
  FilesProvider filesProvider = FilesProvider();
  Database _database = Database();
  DateTime selectInitDate = DateTime.now().subtract(Duration(hours: 6));
  DateTime selectFinalDate = DateTime.now();
  TimeOfDay selectInitTime = TimeOfDay(hour: 19, minute: 0);
  TimeOfDay selectFinalTime = TimeOfDay.now();
  double moneyTotal = 0;
  double money = 30;
  double moneyExtra = 7;
  bool moneyCalc = false;

  /// Public method of report model
  updateDate(DateTime date, bool initDate) {
    initDate ? selectInitDate = date : selectFinalDate = date;
    notifyListeners();
  }

  updateTime(TimeOfDay time, bool initHour) {
    initHour ? selectInitTime = time : selectFinalTime = time;
    notifyListeners();
  }

  updateMoney(bool extraHour) {
    moneyCalc = extraHour;
    notifyListeners();
  }

  insertElement() {
    _reportBuild();
    _database.insert(reportElement);
    updateTotalMoney();
    notifyListeners();
  }

  deleteElement(int id) {
    _database.delete(id);
    updateTotalMoney();
    notifyListeners();
  }

  updateTotalMoney() {
    moneyTotal = 0;
    _database.queryList().then((list) {
      list.forEach((reportElement) {
        moneyTotal += reportElement.money;
      });
      print(moneyTotal);
      notifyListeners();
    });
    notifyListeners();
  }

  exportReport() async {
    filesProvider.writeFile('Total: $moneyTotal \n', false);
    final list = await _database.queryList();
    list.forEach((item) {
      print('Element id: ${item.id}');
      String string =
          '#${item.id}: ${item.initDate} - ${item.finalDate} ${item.initHour} hasta ${item.finalHour} € ${item.money} \n';
      filesProvider.writeFile(string, true);
    });
    filesProvider.readFile().then((string) {
      print(string);
    });
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
    reportElement.money = moneyCalc ? _calcMoney() : 30.0;
    print('Money: ${reportElement.money}');
  }

  double _calcMoney() {
    final timeInit = formatTime.formatTime(selectInitDate, selectInitTime);
    final timeFinal = formatTime.formatTime(selectFinalDate, selectFinalTime);

    int timeWork = timeInit.difference(timeFinal).inMinutes.abs();
    if (timeWork <= 390) {
      return money;
    } else if (timeWork > 390 && timeWork <= 420) {
      return money + moneyExtra / 2;
    } else if (timeWork > 420 && timeWork <= 450) {
      return money + moneyExtra;
    } else if (timeWork > 450 && timeWork <= 480) {
      return money + moneyExtra * 1.5;
    } else {
      return 0;
    }
  }

  static ReportModel of(BuildContext context) => ScopedModel.of<ReportModel>(context);
}

class ReportElement {
  int id;
  String initDate;
  String finalDate;
  String initHour;
  String finalHour;
  double money;

  ReportElement(
      {this.initDate, this.finalDate, this.initHour, this.finalHour, this.money, this.id});
}
