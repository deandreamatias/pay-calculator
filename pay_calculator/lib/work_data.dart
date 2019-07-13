import 'package:flutter/material.dart';

class Work {
  final DateTime date;
  final TimeOfDay inithour;
  final TimeOfDay finalHour;
  final int money;

  Work({this.date, this.inithour, this.finalHour, this.money});
}

var kWork = <Work>[
    new Work(
      date: new DateTime.now(),
      inithour: new TimeOfDay.now(),
      finalHour: new TimeOfDay.now(),
      money: 10
    ),
    new Work(
      date: new DateTime.now(),
      inithour: new TimeOfDay.now(),
      finalHour: new TimeOfDay.now(),
      money: 20
    )
];