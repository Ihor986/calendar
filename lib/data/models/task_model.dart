class TaskModel {
  final int id;
  final String name;
  final String date;
  final String timeFrom;
  final String timeTo;
  final String description;
  final bool isDeleted;
  TaskModel({
    required this.id,
    required this.name,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.description,
    required this.isDeleted,
  });

  TaskModel copyWith({
    int? id,
    String? name,
    String? date,
    String? timeFrom,
    String? timeTo,
    String? description,
    bool? isDeleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TasksFields.id: id,
      TasksFields.name: name,
      TasksFields.date: date,
      TasksFields.timeFrom: timeFrom,
      TasksFields.timeTo: timeTo,
      TasksFields.description: description,
      TasksFields.isDeleted: isDeleted ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[TasksFields.id] as int,
      name: map[TasksFields.name] as String,
      date: map[TasksFields.date] as String,
      timeFrom: map[TasksFields.timeFrom] as String,
      timeTo: map[TasksFields.timeTo] as String,
      description: map[TasksFields.description] as String,
      isDeleted: map[TasksFields.isDeleted] == 1,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, name: $name, date: $date, timeFrom: $timeFrom, timeTo: $timeTo, description: $description, isDeleted: $isDeleted)';
  }
}

const String tasksTable = 'tasks';

class TasksFields {
  static final List<String> values = [
    id,
    name,
    date,
    timeFrom,
    timeTo,
    description,
    isDeleted,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String date = 'date';
  static const String timeFrom = 'timeFrom';
  static const String timeTo = 'timeTo';
  static const String description = 'description';
  static const String isDeleted = 'isDeleted';
}
