import 'package:sqflite/sqflite.dart';

abstract class TableElement {
  int id;
  final String tableName;
  TableElement(this.id, this.tableName);
  void createTable(Database db);
  Map<String, dynamic> toMap();
}

class Report extends TableElement {
  static final String tableTitle = "report";
  String date;
  String initHour;
  String finalHour;
  double money;

  Report({this.date, this.initHour, this.finalHour, this.money, id})
      : super(id, tableTitle);

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
        date: map["date"],
        initHour: map["initHour"],
        finalHour: map["finalHour"],
        money: map["money"],
        id: map["_id"]);
  }

  @override
  void createTable(Database db) {
    db.rawUpdate(
        "CREATE TABLE $tableTitle(_id integer primary key autoincrement, date varchar(30), initHour varchar(30), finalHour varchar(30), money varchar(30),)");
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "date": this.date,
      "initHour": this.initHour,
      "finalHour": this.finalHour,
      "money": this.money
    };
    if (this.id != null) {
      map["_id"] = id;
    }
    return map;
  }
}

final String dbFileName = "crub.db";

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await open();

    return _database;
  }

  Future<Database> open() async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = "$databasesPath/$dbFileName";
      var db = await openDatabase(path, version: 1,
          onCreate: (Database database, int version) {
        new Report().createTable(database);
      });
      return db;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Get list with all elements for database
  Future<List<Report>> getList() async {
    Database dbClient = await db;

    List<Map> maps = await dbClient.query(Report.tableTitle,
        columns: ["_id", "date", "initHour", "finalHour", "money"]);

    return maps.map((i) => Report.fromMap(i)).toList();
  }

  // Insert element in database
  Future<TableElement> insert(TableElement element) async {
    var dbClient = await db;

    element.id = await dbClient.insert(element.tableName, element.toMap());
    print("new Id ${element.id}");
    return element;
  }

  // Delete element in database
  Future<int> delete(TableElement element) async {
    var dbClient = await db;
    return await dbClient
        .delete(element.tableName, where: '_id = ?', whereArgs: [element.id]);
  }

  // Update item in database
  Future<int> update(TableElement element) async {
    var dbClient = await db;

    return await dbClient.update(element.tableName, element.toMap(),
        where: '_id = ?', whereArgs: [element.id]);
  }
}
