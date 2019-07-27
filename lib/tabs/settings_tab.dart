import 'package:flutter/material.dart';
import 'package:pay_calculator/model/report_model.dart';

final ReportModel reportModel = ReportModel();

class Settings extends StatelessWidget {
  TextEditingController _normalHourController =
      TextEditingController(text: reportModel.money.toString());
  TextEditingController _extraHourController =
      TextEditingController(text: reportModel.moneyExtra.toString());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textForm('Hora normal', true),
              _textForm('Hora extra', false),
            ],
          )),
    );
  }

  Widget _textForm(String text, bool normalHour) {
    return TextField(
      controller: normalHour ? _normalHourController : _extraHourController,
      keyboardType: TextInputType.number,
      onChanged: normalHour
          ? _saveMoney(_normalHourController, normalHour)
          : _saveMoney(_extraHourController, normalHour),
      decoration: InputDecoration(icon: Icon(Icons.euro_symbol), helperText: text),
    );
  }

  _saveMoney(TextEditingController value, bool normalHour) {
    normalHour
        ? reportModel.money = double.parse(value.text)
        : reportModel.moneyExtra = double.parse(value.text);
    print('Money ${reportModel.money} | MoneyExtra ${reportModel.moneyExtra}');
  }
}
