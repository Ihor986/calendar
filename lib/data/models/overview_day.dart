class OverviewDay {
  OverviewDay({
    required this.date,
    this.tasksCount = 0,
  });

  final String date;
  final int tasksCount;

  factory OverviewDay.fromMap(Map<String, dynamic> map) {
    return OverviewDay(
      date: map[OverviewDayFields.date] as String,
      tasksCount: map[OverviewDayFields.tasksCount] as int,
    );
  }
}

class OverviewDayFields {
  static final List<String> values = [
    date,
    tasksCount,
  ];

  static const String date = 'date';
  static const String tasksCount = 'tasksCount';
}
