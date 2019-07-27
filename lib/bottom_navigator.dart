import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/tabs/home_tab.dart';
import 'package:pay_calculator/tabs/settings_tab.dart';
import 'package:pay_calculator/tabs/report_tab.dart';
import 'package:pay_calculator/util/colors.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  GlobalKey<ScaffoldState> scaffold_state = GlobalKey<ScaffoldState>();
  final ReportModel reportModel = ReportModel();
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Report(),
    Settings(),
  ];

  @override
  void initState() {
    reportModel.updateTotalMoney();
    super.initState();
  }

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
        key: scaffold_state,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Pay calculator'),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        floatingActionButton: _fab(_selectedIndex),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              title: Text('Reporte'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Configuraçoes'),
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
          final snackBar = SnackBar(
            content: Text('Salvo'),
            duration: Duration(seconds: 2),
          );
          scaffold_state.currentState.showSnackBar(snackBar);
        },
        icon: Icon(Icons.save),
        label: Text("Salvar"),
      );
    } else
      return null;
  }
}
