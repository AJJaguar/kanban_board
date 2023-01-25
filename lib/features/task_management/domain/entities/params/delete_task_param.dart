import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

class DeleteTaskParam {
  const DeleteTaskParam({required this.task});
  final TaskEntity task;

  Map<String, dynamic> toJson() => {
        'status': task,
      };
}
