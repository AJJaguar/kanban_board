import 'package:dartz/dartz.dart';
import 'package:innoscripta_task/core/error/failure.dart';
import 'package:innoscripta_task/core/usecase/usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/params/get_tasks_param.dart';

class GetTasksByStatusUseCase
    extends UseCase<List<TaskEntity>, GetTasksParam?> {
  GetTasksByStatusUseCase(this.taskRepository);
  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, List<TaskEntity>>> call(GetTasksParam? param) {
    return taskRepository.getTasksByStatus(param);
  }
}
