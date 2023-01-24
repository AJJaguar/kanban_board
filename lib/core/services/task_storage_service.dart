import 'dart:collection';

import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

abstract class TaskStorageService {
  Future<List<TaskEntity>> addTask(TaskEntity taskEntity);
  Future<List<TaskEntity>> deleteTask(TaskEntity taskEntity);
  Future<List<TaskEntity>> getTasks();
  Future<List<TaskEntity>> editTask(TaskEntity oldTask, TaskEntity newTask);
}

class ListTaskStorageService implements TaskStorageService {
  final List<TaskEntity> _tasks = [];

  @override
  Future<List<TaskEntity>> addTask(TaskEntity taskEntity) async {
    _tasks.add(taskEntity);
    return UnmodifiableListView(_tasks);
  }

  @override
  Future<List<TaskEntity>> deleteTask(TaskEntity taskEntity) async {
    _tasks.removeWhere((element) => element == taskEntity);
    return UnmodifiableListView(_tasks);
  }

  @override
  Future<List<TaskEntity>> editTask(
    TaskEntity oldTask,
    TaskEntity newTask,
  ) async {
    final index = _tasks.indexOf(oldTask);
    _tasks[index] = newTask;
    return UnmodifiableListView(_tasks);
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    return UnmodifiableListView(_tasks);
  }
}
