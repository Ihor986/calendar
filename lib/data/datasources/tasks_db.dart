import 'package:calendar/data/datasources/app_db.dart';
import 'package:calendar/data/models/task_model.dart';
import 'package:sqflite/sqlite_api.dart';

class TasksDB extends AppDB {
  TasksDB._();
  static final TasksDB instance = TasksDB._();

  Future<TaskModel> create(TaskModel task) async {
    final Database db = await instance.database;
    final id = await db.insert(tasksTable, task.toMap());
    return task.copyWith(id: id);
  }

  Future<List<TaskModel>?> readDay(String date) async {
    final Database db = await instance.database;
    const String orderBy = '${TasksFields.time} ASC';
    final res = await db.rawQuery(
      '''SELECT * 
        FROM $tasksTable
        WHERE ${TasksFields.date} LIKE ?
        ORDER BY $orderBy''',
      [date],
    );

    if (res.isEmpty) return null;
    return res.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<int?> delete(int value) async {
    final Database db = await instance.database;
    return db.delete(
      tasksTable,
      where: '${TasksFields.id} = ?',
      whereArgs: [value],
    );
  }

  @override
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
