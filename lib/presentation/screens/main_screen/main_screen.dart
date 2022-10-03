import 'package:calendar/common/app_colors.dart';
import 'package:calendar/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:calendar/presentation/screens/main_screen/widgets/calendar_table.dart';
import 'package:calendar/presentation/screens/main_screen/widgets/date_picker.dart';
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
              CalendarTable(),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
