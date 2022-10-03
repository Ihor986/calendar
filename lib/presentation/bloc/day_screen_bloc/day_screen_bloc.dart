import 'package:calendar/data/models/task_model.dart';
import 'package:calendar/data/repositories/details_day_rep.dart';
import 'package:calendar/services/text/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'day_screen_event.dart';
part 'day_screen_state.dart';

class DayScreenBloc extends Bloc<DayScreenEvent, DayScreenState> {
  DayScreenBloc() : super(DayScreenState(textController: TaskController())) {
    on<GetTasksEvent>((event, emit) async {
      final List<TaskModel> list = await repository.getDetails(event.date);

      emit(state.copyWith(list: list));
    });

    on<SelectTimeEvent>((event, emit) {
      state.textController.time.text = event.time;
    });

    on<CreateTaskEvent>((event, emit) async {
      final TaskModel task = TaskModel(
        name: state.textController.name.text,
        date: event.date,
        time: state.textController.time.text,
        description: state.textController.description.text,
      );

      await repository.createTask(task);

      final List<TaskModel> list = await repository.getDetails(event.date);

      emit(state.copyWith(
        list: list,
        textController: TaskController(),
      ));
    });

    on<DeleteTaskEvent>((event, emit) async {
      if (event.task.id == null) return;
      await repository.deleteTask(event.task.id!);
      final List<TaskModel> list = await repository.getDetails(event.task.date);
      emit(state.copyWith(list: list));
    });

    on<ClearInputsEvent>((event, emit) {
      emit(state.copyWith(textController: TaskController()));
    });
  }

  final DetailsDayRep repository = DetailsDayRep.instance;
}
