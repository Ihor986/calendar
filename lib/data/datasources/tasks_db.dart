import 'package:calendar/data/datasources/app_db.dart';
import 'package:calendar/data/models/task_model.dart';

class TasksDB extends AppDB {
  TasksDB._();
  static final TasksDB instance = TasksDB._();

  Future<TaskModel> create(TaskModel value) async {
    return value;
  }

  Future<TaskModel?> read(int value) async {
    return null;
  }

  Future<int?> update(TaskModel value) async {
    return null;
  }

  Future<int?> delete(int value) async {
    return null;
  }

  @override
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
