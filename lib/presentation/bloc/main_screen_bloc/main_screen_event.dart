part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent {}

class GetMonthEvent extends MainScreenEvent {
  GetMonthEvent({
    this.selectedMonth,
    this.selectedYear,
  });

  final int? selectedMonth;
  final int? selectedYear;
}
