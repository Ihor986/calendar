part of 'day_screen_bloc.dart';

@immutable
abstract class DayScreenEvent {}

class GetTasksEvent extends DayScreenEvent {
  GetTasksEvent({required this.date});

  final String date;
}

class SelectTimeEvent extends DayScreenEvent {
  SelectTimeEvent({required this.time});

  final String time;
}

class CreateTaskEvent extends DayScreenEvent {
  CreateTaskEvent({required this.date});

  final String date;
}

class DeleteTaskEvent extends DayScreenEvent {
  DeleteTaskEvent({required this.task});

  final TaskModel task;
}

class ClearInputsEvent extends DayScreenEvent {}
