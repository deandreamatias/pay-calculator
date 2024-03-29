import 'package:flutter/material.dart';

import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/util/database.dart';
import 'package:scoped_model/scoped_model.dart';

class Report extends StatefulWidget {
  Report({Key key}) : super(key: key);

  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final Database database = Database();
  List<ReportElement> listElements;
  bool _listWidget;

  @override
  void initState() {
    _listWidget = false;
    _loadList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _listWidget ? listView() : loadingWidget();
  }

  Widget listView() {
    return ScopedModelDescendant<ReportModel>(builder: (context, child, model) {
      return ListView.builder(
        itemCount: listElements.length,
        itemBuilder: (context, index) {
          final listElement = listElements[index];
          return ListTile(
            onLongPress: () {
              model.deleteElement(listElement.id);
              setState(() {
                _listWidget = false;
              });
              _loadList();
            },
            leading: Text(listElement.initDate),
            title: Text(listElement.initHour + ' hasta ' + listElement.finalHour),
            trailing: Text('€ ${listElement.money.toString()}'),
          );
        },
      );
    });
  }

  Widget loadingWidget() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  _loadList() {
    database.queryList().then((list) {
      setState(() {
        listElements = list;
        _listWidget = true;
      });
    });
  }
}
