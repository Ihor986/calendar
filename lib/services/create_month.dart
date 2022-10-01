import 'package:calendar/data/models/overview_day.dart';

class CreateMonth {
  List<List<OverviewDay>> call(
    String yearMonth,
    List<OverviewDay> tasks,
  ) {
    final _GetStartDate getStartDate = _GetStartDate();
    final List<List<OverviewDay>> list = [[], [], [], [], [], []];

    final _GetOverviewDay getDay = _GetOverviewDay();

    DateTime date = getStartDate(yearMonth);

    for (var i = 0; i < 6; i++) {
      for (var y = 0; y < 7; y++) {
        date = date.add(const Duration(days: 1));
        var day = getDay(tasks, date);
        list.elementAt(i).add(day);
      }
    }

    return list;
  }
}

class _GetOverviewDay {
  OverviewDay call(List<OverviewDay> tasks, DateTime startDate) {
    if (tasks.isEmpty) {
      return OverviewDay(date: startDate.toString());
    }
    return tasks.firstWhere(
      (e) => e.date == startDate.toString(),
      orElse: () => OverviewDay(date: startDate.toString()),
    );
  }
}

class _GetStartDate {
  DateTime call(String date) {
    final int y = int.tryParse(date.substring(0, 4)) ?? DateTime.now().year;
    final int m = int.tryParse(date.substring(5)) ?? DateTime.now().month;
    final int weekday = DateTime(y, m).weekday;
    final DateTime startDate = DateTime(y, m).subtract(
      Duration(days: weekday),
    );
    return startDate;
  }
}
