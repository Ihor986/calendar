// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_screen_bloc.dart';

class MainScreenState {
  MainScreenState({
    required this.selectedMonth,
    required this.selectedYear,
    this.weeks = const [],
  });

  final String selectedMonth;
  final String selectedYear;
  final List<List<OverviewDay>> weeks;

  MainScreenState copyWith({
    String? selectedMonth,
    String? selectedYear,
    List<List<OverviewDay>>? weeks,
  }) {
    return MainScreenState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      weeks: weeks ?? this.weeks,
    );
  }

  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final List<String> days = const [
    'mon',
    'tue',
    'wed',
    'thu',
    'fri',
    'sat',
    'sun',
  ];
}
