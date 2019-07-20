import 'package:flutter/material.dart';

import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/util/database.dart';

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
    initList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _listWidget ? listView() : loadingWidget();
  }

  Widget listView() {
    return ListView.builder(
      itemCount: listElements.length,
      itemBuilder: (context, index) {
        final listElement = listElements[index];
        return ListTile(
          leading: Text(listElement.initHour),
          title: Text(listElement.finalHour),
          trailing: Text(listElement.money.toString()),
        );
      },
    );
  }

  Widget loadingWidget() {
    return Container(
      child: CircularProgressIndicator(),
    );
  }

  void initList() {
    database.queryList().then((list) {
      setState(() {
        listElements = list;
        _listWidget = true;
      });
    });
  }
}