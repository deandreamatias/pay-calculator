import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectTime = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 2),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context, bool initHour) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectTime);
    if (picked != null && picked != selectTime){
      setState(() {
        selectTime = picked;
      });
      initHour ? initTime = selectTime : finalTime = selectTime;
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _selectTime(context, true),
              child: Text("${selectTime.hour}:${selectTime.minute}"),
              color: Colors.blue,
            ),
            RaisedButton(
              onPressed: () => _selectTime(context, false),
              child: Text("${selectTime.hour}:${selectTime.minute}"),
              color: Colors.blue,
            ),
          ],
        ),
    );
  }
}

