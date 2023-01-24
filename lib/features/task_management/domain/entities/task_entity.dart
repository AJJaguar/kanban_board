import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  const TaskEntity({
    required this.status,
    required this.title,
    required this.description,
    required this.seconds,
    required this.createdAt,
  });

  final String title;
  final String description;
  final int seconds;
  final DateTime createdAt;
  final TaskStatus status;

  @override
  String toString() => '{ title: $title,  description: $description, '
      'time: $seconds, status: $status}';

  TaskEntity copyWith({
    String? title,
    String? description,
    int? time,
    TaskStatus? status,
  }) =>
      TaskEntity(
        createdAt: createdAt,
        description: description ?? this.description,
        status: status ?? this.status,
        seconds: time ?? this.seconds,
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        seconds,
        createdAt,
        status,
      ];
}

enum TaskStatus {
  todo,
  inProgress,
  done,
}
