import 'package:flutter/material.dart';

import 'package:pay_calculator/bottom_navigator.dart';
import 'package:pay_calculator/util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: primaryColor,
      theme: ThemeData.light(),
      home: BottomNavigator(),
    );
  }
}
