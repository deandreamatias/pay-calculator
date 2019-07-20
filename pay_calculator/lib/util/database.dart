import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/util/database_helper.dart';

class Database {

  final dbHelper = DatabaseHelper.instance;
  
  void insert(ReportElement reportElement) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnDate : reportElement.date,
      DatabaseHelper.columnInitHour  : reportElement.initHour,
      DatabaseHelper.columnFinalHour  : reportElement.finalHour,
      DatabaseHelper.columnMoney  : reportElement.money
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  Future<List<ReportElement>> queryList() async {
    final list = await dbHelper.queryList();
    print('query list:');
    return list;
  }


  void update(ReportElement reportElement) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : reportElement.id,
      DatabaseHelper.columnDate : reportElement.date,
      DatabaseHelper.columnInitHour  : reportElement.initHour,
      DatabaseHelper.columnFinalHour  : reportElement.finalHour,
      DatabaseHelper.columnMoney  : reportElement.money
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

}