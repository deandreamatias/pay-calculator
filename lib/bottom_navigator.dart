import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/tabs/home.dart';
import 'package:pay_calculator/tabs/settings.dart';
import 'package:pay_calculator/tabs/report.dart';
import 'package:pay_calculator/util/colors.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  final ReportModel reportModel = ReportModel();
  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Report(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ReportModel>(
      model: reportModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Pay calculator'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: _fab(_selectedIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text('Table'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _fab(int index) {
    if (index == 0) {
      return FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () {
          reportModel.insertElement();
        },
        icon: Icon(Icons.save),
        label: Text("Save"),
      );
    } else
      return null;
  }
}
