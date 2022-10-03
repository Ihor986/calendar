import 'package:calendar/data/datasources/overview_day_db.dart';
import 'package:calendar/data/models/overview_day.dart';
import 'package:calendar/services/create_month.dart';

class OverviewDayRep {
  const OverviewDayRep._();
  static const OverviewDayRep instance = OverviewDayRep._();

  Future<List<List<OverviewDay>>> getOverview(
    String last,
    String date,
    String next,
  ) async {
    final OverviewDayDB db = OverviewDayDB.instance;
    final CreateMonth month = CreateMonth();
    final List<OverviewDay>? tasks = await db.read(
      '$last%',
      '$date%',
      '$next%',
    );
    final List<List<OverviewDay>> list = month(date, tasks ?? []);

    return list;
  }
}
