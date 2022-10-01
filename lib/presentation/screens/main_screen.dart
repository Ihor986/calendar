import 'package:calendar/common/app_colors.dart';
import 'package:calendar/data/models/overview_day.dart';
import 'package:calendar/presentation/bloc/main_screen_bloc.dart';
import 'package:calendar/presentation/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<MainScreenBloc>().add(GetMonthEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Tasks'),
        titleTextStyle: const TextStyle(
          color: AppColors.blue,
          fontSize: 24,
        ),
        backgroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              DatePicker(),
              Spacer(),
              _CalendarTable(),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarTable extends StatelessWidget {
  const _CalendarTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainScreenBloc, MainScreenState,
        List<List<OverviewDay>>>(
      selector: (state) {
        return state.weeks;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _WeekDays(),
            Table(
              children: [
                ...List.generate(
                  6,
                  (indexW) => TableRow(
                    children: [
                      ...List.generate(
                        7,
                        (indexD) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _OverviewDay(
                            day: state.isEmpty
                                ? OverviewDay(
                                    date: DateTime.now().toString(),
                                    tasksCount: 5)
                                : state.elementAt(indexW).elementAt(indexD),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class _WeekDays extends StatelessWidget {
  const _WeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return FittedBox(
          child: Row(
            children: [
              ...List.generate(
                state.days.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.days.elementAt(index).toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _OverviewDay extends StatelessWidget {
  const _OverviewDay({
    required this.day,
    Key? key,
  }) : super(key: key);

  final OverviewDay day;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainScreenBloc, MainScreenState, String>(
      selector: (state) {
        return state.selectedMonth;
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            print('date');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              color: day.date.substring(5, 7) == state
                  ? AppColors.gray
                  : AppColors.white,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 3,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      day.date.substring(8, 10),
                      style: day.date.substring(5, 7) == state
                          ? const TextStyle(fontSize: 16, color: AppColors.text)
                          : const TextStyle(
                              fontSize: 16, color: AppColors.blue),
                    ),
                  ),
                ),
                day.tasksCount > 0
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          day.tasksCount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }
}
