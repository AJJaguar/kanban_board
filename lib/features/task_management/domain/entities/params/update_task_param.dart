import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

class UpdateTaskParam {
  UpdateTaskParam({required this.oldTask, required this.newTask});

  final TaskEntity oldTask;
  final TaskEntity newTask;
}
