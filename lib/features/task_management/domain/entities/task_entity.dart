import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  const TaskEntity({
    required this.status,
    required this.title,
    required this.description,
    required this.seconds,
    this.completedAt,
  });

  final String title;
  final String description;
  final int seconds;
  final DateTime? completedAt;
  final TaskStatus status;

  @override
  String toString() => '{ title: $title,  description: $description, '
      'time: $seconds, status: $status}';

  TaskEntity copyWith({
    String? title,
    String? description,
    int? seconds,
    TaskStatus? status,
    DateTime? completedAt,
  }) =>
      TaskEntity(
        description: description ?? this.description,
        status: status ?? this.status,
        seconds: seconds ?? this.seconds,
        title: title ?? this.title,
        completedAt: completedAt,
      );

  @override
  List<Object?> get props => [
        title,
        description,
        seconds,
        completedAt,
        status,
      ];
}

enum TaskStatus {
  todo,
  inProgress,
  done,
}
