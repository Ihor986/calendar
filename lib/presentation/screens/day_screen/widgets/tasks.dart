import 'package:calendar/common/app_colors.dart';
import 'package:calendar/data/models/task_model.dart';
import 'package:calendar/presentation/bloc/day_screen_bloc/day_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DayScreenBloc, DayScreenState>(
      builder: (context, state) {
        return Expanded(
          child: RefreshIndicator(
            color: AppColors.blue,
            onRefresh: () async {
              context.read<DayScreenBloc>().add(
                    GetTasksEvent(date: date),
                  );
            },
            child: ListView.separated(
              itemCount: state.list.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                return _Task(
                  task: state.list.elementAt(index),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Task extends StatefulWidget {
  const _Task({
    required this.task,
    Key? key,
  }) : super(key: key);

  final TaskModel task;

  @override
  State<_Task> createState() => __TaskState();
}

class __TaskState extends State<_Task> {
  bool isDetails = false;

  Future<bool?> _showConfirmationDialog(BuildContext context, String action) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(action),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                if (widget.task.id == null) return;
                context.read<DayScreenBloc>().add(
                      DeleteTaskEvent(task: widget.task),
                    );
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id.toString()),
      confirmDismiss: (direction) async {
        return await _showConfirmationDialog(
                context, 'Do you want to delete ${widget.task.name} ?') ==
            true;
      },
      background: Container(color: AppColors.red),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            isDetails = !isDetails;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(
              color: AppColors.text,
            ),
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Text(widget.task.name)),
                  Text(
                    widget.task.time,
                    style: const TextStyle(
                      color: AppColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: isDetails
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.task.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
