import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/util/colors.dart';
import 'package:pay_calculator/util/format_time.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FormatTime formatTime = FormatTime();
  bool extraHour;

  @override
  void initState() {
    extraHour = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ReportModel>(builder: (context, child, model) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Init hour'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _selectDate(context, true, model),
                    child: Text(formatTime.dateToString(model.selectInitDate),
                        style: TextStyle(color: lightColor)),
                    color: primaryColor,
                  ),
                  RaisedButton(
                    onPressed: () => _selectTime(context, true, model),
                    child: Text(formatTime.timeToString(model.selectInitTime),
                        style: TextStyle(color: lightColor)),
                    color: primaryColor,
                  )
                ],
              ),
              Text('Final hour'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _selectDate(context, false, model),
                    child: Text(formatTime.dateToString(model.selectFinalDate),
                        style: TextStyle(color: lightColor)),
                    color: primaryColor,
                  ),
                  RaisedButton(
                    onPressed: () => _selectTime(context, false, model),
                    child: Text(formatTime.timeToString(model.selectFinalTime),
                        style: TextStyle(color: lightColor)),
                    color: primaryColor,
                  )
                ],
              ),
              CheckboxListTile(
                onChanged: (check) {
                  setState(() {
                    extraHour = check;
                    model.updateMoney(extraHour);
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                value: extraHour,
                title: Text('Calcular horas extras'),
              )
            ],
          ),
        ),
      );
    });
  }
}

Future<Null> _selectDate(BuildContext context, bool initDate, ReportModel model) async {
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initDate ? model.selectInitDate : model.selectFinalDate,
      firstDate: DateTime(2019, 2),
      lastDate: DateTime(2050));
  if (picked != null) {
    model.updateDate(picked, initDate);
  }
}

Future<Null> _selectTime(BuildContext context, bool initHour, ReportModel model) async {
  final TimeOfDay picked = await showTimePicker(
      context: context, initialTime: initHour ? model.selectInitTime : model.selectFinalTime);
  if (picked != null) {
    model.updateTime(picked, initHour);
  }
}
