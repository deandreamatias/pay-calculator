import 'package:flutter/material.dart';
import 'package:pay_calculator/model/report_model.dart';

class Settings extends StatelessWidget {
  final ReportModel reportModel = ReportModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _textForm('Normal hour', true),
              _textForm('Extra hour', false),
            ],
          )),
    );
  }

  // TODO: Edit controller in money fields
  Widget _textForm(String text, bool normalHour) {
  return TextFormField(
        keyboardType: TextInputType.number,
        initialValue: normalHour ? reportModel.money.toString() : reportModel.moneyExtra.toString(),
        onFieldSubmitted: (money) => _saveMoney(int.parse(money), normalHour),
        onEditingComplete: () => print('Dynamic'),
        onSaved: (money) => _saveMoney(int.parse(money), normalHour),
        decoration: InputDecoration(
            icon: Icon(Icons.euro_symbol),
            helperText: text),
      );
  }
  _saveMoney(dynamic money, bool normalHour){
    normalHour ? reportModel.money = money : reportModel.moneyExtra = money;
    print('Money ${reportModel.money} | MoneyExtra ${reportModel.moneyExtra}');
  }
}

