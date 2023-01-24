import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.title,
    required super.description,
    required super.seconds,
    required super.createdAt,
    required super.status,
  });
}
