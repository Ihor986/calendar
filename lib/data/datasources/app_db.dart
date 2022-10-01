import 'package:calendar/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppDB {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('/tasks/db.db');
    _db?.getVersion();
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const String integerType = 'INTEGER NOT NULL';
    const String textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tasksTable (
      ${TasksFields.id} $idType,
      ${TasksFields.name} $integerType,
      ${TasksFields.date} $textType,
      ${TasksFields.timeFrom} $textType,
      ${TasksFields.timeTo} $textType,
      ${TasksFields.description} $textType,
      ${TasksFields.isDeleted} $integerType
      )
      ''');
  }

  Future close();
}
