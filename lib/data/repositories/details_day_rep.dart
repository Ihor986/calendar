import 'package:calendar/data/datasources/tasks_db.dart';
import 'package:calendar/data/models/task_model.dart';

class DetailsDayRep {
  const DetailsDayRep._();
  static const DetailsDayRep instance = DetailsDayRep._();

  Future<List<TaskModel>> getDetails(String date) async {
    final TasksDB db = TasksDB.instance;
    final List<TaskModel>? tasks =
        await db.readDay('${date.substring(0, 10)}%');

    return tasks ?? [];
  }

  Future<TaskModel> createTask(TaskModel value) async {
    final TasksDB db = TasksDB.instance;

    await db.create(value);

    return value;
  }

  Future<int?> deleteTask(int value) async {
    final TasksDB db = TasksDB.instance;

    return await db.delete(value);
  }
}
