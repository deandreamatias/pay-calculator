import 'package:pay_calculator/model/report_model.dart';
import 'package:pay_calculator/util/database_helper.dart';

class Database {

  final dbHelper = DatabaseHelper.instance;
  
  void insert(ReportElement reportElement) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnInitDate : reportElement.initDate,
      DatabaseHelper.columnFinalDate : reportElement.finalDate,
      DatabaseHelper.columnInitHour  : reportElement.initHour,
      DatabaseHelper.columnFinalHour  : reportElement.finalHour,
      DatabaseHelper.columnMoney  : reportElement.money
    };
    final id = await dbHelper.insert(row);
    print('Inserted row: $id');
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  Future<List<ReportElement>> queryList() async {
    final list = await dbHelper.queryList();
    print('Query list');
    return list;
  }


  void update(ReportElement reportElement) async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : reportElement.id,
      DatabaseHelper.columnInitDate : reportElement.initDate,
      DatabaseHelper.columnFinalDate : reportElement.finalDate,
      DatabaseHelper.columnInitHour  : reportElement.initHour,
      DatabaseHelper.columnFinalHour  : reportElement.finalHour,
      DatabaseHelper.columnMoney  : reportElement.money
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void delete(int id) async {
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row: $id');
  }

}