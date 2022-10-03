import 'package:calendar/data/datasources/app_db.dart';
import 'package:calendar/data/models/overview_day.dart';
import 'package:calendar/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class OverviewDayDB extends AppDB {
  OverviewDayDB._();
  static final OverviewDayDB instance = OverviewDayDB._();

  Future<List<OverviewDay>?> read(String last, String date, String next) async {
    final Database db = await instance.database;
    const String orderBy = '${TasksFields.date} DESC';
    final res = await db.rawQuery(
      '''SELECT 
        ${TasksFields.date} AS ${OverviewDayFields.date},
        COUNT(${TasksFields.date}) 
        AS ${OverviewDayFields.tasksCount}
        FROM $tasksTable
        WHERE ${TasksFields.date} LIKE ?
        OR ${TasksFields.date} LIKE ?
        OR ${TasksFields.date} LIKE ?
        GROUP BY ${TasksFields.date}
        ORDER BY $orderBy''',
      [last, date, next],
    );

    if (res.isEmpty) return null;
    return res.map((e) => OverviewDay.fromMap(e)).toList();
  }

  @override
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
