part of 'day_screen_bloc.dart';

class DayScreenState {
  DayScreenState({
    this.list = const [],
    required this.textController,
  });

  final List<TaskModel> list;
  final TaskController textController;

  DayScreenState copyWith({
    List<TaskModel>? list,
    TaskController? textController,
  }) {
    return DayScreenState(
      list: list ?? this.list,
      textController: textController ?? this.textController,
    );
  }
}
