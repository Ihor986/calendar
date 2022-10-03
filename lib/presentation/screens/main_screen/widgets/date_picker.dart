import 'package:calendar/common/app_colors.dart';
import 'package:calendar/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _MonthDec(
                month: state.selectedMonth,
                year: state.selectedYear,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                width: 130,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.text,
                      size: 16,
                    ),
                    const Spacer(),
                    Text(
                      state.months
                          .elementAt(int.parse(state.selectedMonth) - 1),
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      state.selectedYear,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // ),
              _MonthInc(
                month: state.selectedMonth,
                year: state.selectedYear,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MonthDec extends StatelessWidget {
  const _MonthDec({
    required this.month,
    required this.year,
    Key? key,
  }) : super(key: key);
  final String month;
  final String year;

  void monthDec(
    BuildContext context,
  ) {
    if (month == '01') {
      context.read<MainScreenBloc>().add(
            GetMonthEvent(
              selectedMonth: 12,
              selectedYear: int.parse(year) - 1,
            ),
          );
      return;
    }
    context.read<MainScreenBloc>().add(
          GetMonthEvent(
            selectedMonth: int.parse(month) - 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        monthDec(
          context,
        );
      },
      child: const SizedBox(
        width: 30,
        child: Icon(
          Icons.arrow_left,
          color: AppColors.text,
        ),
      ),
    );
  }
}

class _MonthInc extends StatelessWidget {
  const _MonthInc({
    required this.month,
    required this.year,
    Key? key,
  }) : super(key: key);
  final String month;
  final String year;

  void monthInc(
    BuildContext context,
  ) {
    if (month == '12') {
      context.read<MainScreenBloc>().add(
            GetMonthEvent(
              selectedMonth: 1,
              selectedYear: int.parse(year) + 1,
            ),
          );
      return;
    }
    context.read<MainScreenBloc>().add(
          GetMonthEvent(
            selectedMonth: int.parse(month) + 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        monthInc(
          context,
        );
      },
      child: const SizedBox(
        width: 30,
        child: Icon(
          Icons.arrow_right,
          color: AppColors.text,
        ),
      ),
    );
  }
}
