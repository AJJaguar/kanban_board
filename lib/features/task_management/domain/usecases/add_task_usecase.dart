import 'package:dartz/dartz.dart';
import 'package:innoscripta_task/core/error/failure.dart';
import 'package:innoscripta_task/core/usecase/usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/params/add_task_param.dart';

class AddTaskUseCase extends UseCase<List<TaskEntity>, AddTaskParam> {
  AddTaskUseCase(this.taskRepository);
  final TaskRepository taskRepository;
  @override
  Future<Either<Failure, List<TaskEntity>>> call(AddTaskParam param) {
    return taskRepository.addTask(param);
  }
}
