import 'package:flutter/material.dart';
import 'package:pay_calculator/model/report_model.dart';

import 'package:pay_calculator/util/format_time.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FormatTime formatTime = FormatTime();
  final ReportModel reportModel = ReportModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text(formatTime.dateToString(reportModel.selectedDate)),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _selectTime(context, true),
              child: Text(formatTime.timeToString(reportModel.selectTimeInit)),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _selectTime(context, false),
              child: Text(formatTime.timeToString(reportModel.selectTimeFinal)),
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
              title: Text('Calcular horas extras'),
            ),
            Text('Aqui vou colocar o valor de money')
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: reportModel.selectedDate,
        firstDate: DateTime(2019, 2),
        lastDate: DateTime(2050));
    if (picked != null && picked != reportModel.selectedDate) {
      setState(() {
        reportModel.selectedDate = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, bool initHour) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: initHour
            ? reportModel.selectTimeInit
            : reportModel.selectTimeFinal);
    if (picked != null) {
      setState(() {
        initHour
            ? reportModel.selectTimeInit = picked
            : reportModel.selectTimeFinal = picked;
      });
    }
  }
}
