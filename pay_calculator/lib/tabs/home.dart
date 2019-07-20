import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pay_calculator/database/database.dart';

final String DB_NAME = "report_zamora";

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Report nTable = new Report();
  String calcMoney = "text";
  List<Report> _list;
  DatabaseHelper _databaseHelper;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectTimeInit, selectTimeFinal = TimeOfDay.now();

  @override
  void initState() {
    selectedDate = DateTime.now();
    selectTimeInit = TimeOfDay.now(); 
    selectTimeFinal = TimeOfDay.now();
    _databaseHelper = new DatabaseHelper();
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 2),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        nTable.date = _formatDate(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, bool initHour) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: initHour ? selectTimeInit : selectTimeFinal);
    if (picked != null) {
      setState(() {
        if (initHour) {
          selectTimeInit = picked;
          nTable.initHour = _formatTime(selectTimeInit);
        } else {
          selectTimeFinal = picked;
          nTable.finalHour = _formatTime(selectTimeFinal);
        }
        _calcMoney();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            onPressed: () => {_selectDate(context)},
            child: Text(_formatDate(selectedDate)),
            color: Colors.blue,
          ),
          RaisedButton(
            onPressed: () => {_selectTime(context, true)},
            child: Text(_formatTime(selectTimeInit)),
            color: Colors.blue,
          ),
          RaisedButton(
            onPressed: () => {_selectTime(context, false)},
            child: Text(_formatTime(selectTimeFinal)),
            color: Colors.blue,
          ),
          CheckboxListTile(
            // onChanged: (bool check) {
            //   setState(() {
            //     _calcMoney();
            //   });
            // },
            controlAffinity: ListTileControlAffinity.leading,
            value: false,
            title: Text("Horas extras pagas"),
          ),
          Text(nTable.money.toString())
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd/MM").format(date);
  }

  String _formatTime(TimeOfDay time) {
    return time.hour.toString() + ":" + time.minute.toString();
  }

  void _calcMoney() {

    final timeInit = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectTimeInit.hour, selectTimeInit.minute);
    final timeFinal = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectTimeFinal.hour, selectTimeFinal.minute);
    int timeWork = timeInit.difference(timeFinal).inMinutes.abs();
    if (timeWork <= 390){
      nTable.money = 30.0;
    }else if (timeWork > 390 && timeWork < 420){
      nTable.money = 33.5;
    }else if (timeWork > 420 && timeWork < 450){
      nTable.money = 37.0;
    }

    print(nTable.money);
    print(timeWork);
  
  }

  void insert(BuildContext context, var textToSave) {
    _databaseHelper.insert(nTable).then((value) {
      updateList();
    });
  }

  void updateList() {
    _databaseHelper.getList().then((resultList) {
      setState(() {
        _list = resultList;
      });
    });
  }
}
