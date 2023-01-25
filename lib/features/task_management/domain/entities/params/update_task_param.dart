import 'package:equatable/equatable.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

class UpdateTaskParam extends Equatable {
  UpdateTaskParam({required this.oldTask, required this.newTask});

  final TaskEntity oldTask;
  final TaskEntity newTask;
  Map<String, dynamic> toJson() => {
        'oldTask': oldTask,
        'newTask': newTask,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        oldTask,
        newTask,
      ];
}
