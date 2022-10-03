class TaskModel {
  final int? id;
  final String name;
  final String date;
  final String time;
  final String description;
  final bool isDeleted;
  TaskModel({
    this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    this.isDeleted = false,
  });

  TaskModel copyWith({
    int? id,
    String? name,
    String? date,
    String? time,
    String? description,
    bool? isDeleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      TasksFields.id: id,
      TasksFields.name: name,
      TasksFields.date: date,
      TasksFields.time: time,
      TasksFields.description: description,
      TasksFields.isDeleted: isDeleted ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map[TasksFields.id] as int,
      name: map[TasksFields.name] as String,
      date: map[TasksFields.date] as String,
      time: map[TasksFields.time] as String,
      description: map[TasksFields.description] as String,
      isDeleted: map[TasksFields.isDeleted] == 1,
    );
  }
}

const String tasksTable = 'tasks';

class TasksFields {
  static final List<String> values = [
    id,
    name,
    date,
    time,
    description,
    isDeleted,
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String date = 'date';
  static const String time = 'time';
  static const String description = 'description';
  static const String isDeleted = 'isDeleted';
}
