import 'package:flutter/material.dart';
import 'package:pay_calculator/model/report_model.dart';

import 'package:pay_calculator/util/format_time.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final FormatTime formatTime = FormatTime();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ReportModel>(builder: (context, child, model) {
      return Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () => _selectDate(context, model),
                child: Text(formatTime.dateToString(model.selectedDate)),
                color: Colors.blue,
              ),
              RaisedButton(
                onPressed: () => _selectTime(context, true, model),
                child: Text(formatTime.timeToString(model.selectTimeInit)),
                color: Colors.blue,
              ),
              RaisedButton(
                onPressed: () => _selectTime(context, false, model),
                child: Text(formatTime.timeToString(model.selectTimeFinal)),
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
              )
            ],
          ),
        ),
      );
    });
  }

  Future<Null> _selectDate(BuildContext context, ReportModel model) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: model.selectedDate,
        firstDate: DateTime(2019, 2),
        lastDate: DateTime(2050));
    if (picked != null && picked != model.selectedDate) {
        model.updateDate(picked);
    }
  }

  Future<Null> _selectTime(BuildContext context, bool initHour, ReportModel model) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: initHour
            ? model.selectTimeInit
            : model.selectTimeFinal);
    if (picked != null) {
        model.updateTime(picked, initHour);
    }
  }
}
