import 'package:dartz/dartz.dart';
import 'package:innoscripta_task/core/error/failure.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/delete_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/get_tasks_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> addTask(AddTaskParam param);
  Future<Either<Failure, List<TaskEntity>>> getTasksByStatus(
    GetTasksParam? param,
  );
  Future<Either<Failure, List<TaskEntity>>> updateTask(UpdateTaskParam param);
  Future<Either<Failure, List<TaskEntity>>> deleteTasks(DeleteTaskParam param);
}
