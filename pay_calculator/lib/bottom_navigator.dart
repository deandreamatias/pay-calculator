import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';
import 'report.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xunfles paid'),
      ),
      body:_widgetOptions.elementAt(_selectedIndex),
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _fab (int index){
  if (index == 0) {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: Icon(Icons.save),
      label: Text("Save"),
    );
  }
  else
    return null;
}
