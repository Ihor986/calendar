import 'package:calendar/presentation/screens/day_screen/widgets/bottom_button.dart';
import 'package:calendar/presentation/screens/day_screen/widgets/tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calendar/common/app_colors.dart';
import 'package:calendar/presentation/bloc/day_screen_bloc/day_screen_bloc.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({
    Key? key,
    required this.date,
  }) : super(key: key);
  static const routeName = '/DayScreen';

  final String date;

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  @override
  void initState() {
    context.read<DayScreenBloc>().add(
          GetTasksEvent(date: widget.date),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.text,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        centerTitle: true,
        title: Text(widget.date.substring(0, 10)),
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
            children: [
              Tasks(date: widget.date),
              const SizedBox(height: 10),
              BottomButton(date: widget.date),
            ],
          ),
        ),
      ),
    );
  }
}
