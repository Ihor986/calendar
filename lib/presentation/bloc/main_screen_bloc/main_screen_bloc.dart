import 'package:calendar/data/models/overview_day.dart';
import 'package:calendar/data/repositories/overview_day_rep.dart';
import 'package:calendar/services/text/decrement_year_month.dart';
import 'package:calendar/services/text/increment_year_month.dart';
import 'package:calendar/services/text/two_digit_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc()
      : super(MainScreenState(
          selectedMonth: DateTime.now().month.toString(),
          selectedYear: DateTime.now().year.toString(),
        )) {
    on<GetMonthEvent>(
      (event, emit) async {
        final String selectedMonth =
            format(event.selectedMonth?.toString() ?? state.selectedMonth);

        final String selectedYear =
            event.selectedYear?.toString() ?? state.selectedYear;
        final List<List<OverviewDay>> weeks = await overviewRep.getOverview(
          dec(selectedYear, selectedMonth),
          '$selectedYear-$selectedMonth',
          inc(selectedYear, selectedMonth),
        );
        emit(
          state.copyWith(
            selectedMonth: selectedMonth,
            selectedYear: selectedYear,
            weeks: weeks,
          ),
        );
      },
    );
  }

  final OverviewDayRep overviewRep = OverviewDayRep.instance;
  final TwoDigitFormat format = TwoDigitFormat();
  final DecrementYearMonth dec = DecrementYearMonth();
  final IncrementYearMonth inc = IncrementYearMonth();
}
