part of 'task_bloc.dart';

abstract class TaskState {
  TaskState({this.tasks = const []});
  final List<TaskEntity> tasks;
}

class TaskInitial extends TaskState {
  TaskInitial({super.tasks});
}

class TaskLoading extends TaskState {
  TaskLoading({super.tasks});
}

class TaskLoaded extends TaskState {
  TaskLoaded({super.tasks});
}

class TaskEventFailed extends TaskState {
  TaskEventFailed({super.tasks});
}

class TaskAdded extends TaskState {
  TaskAdded({super.tasks});
}

class TaskDeleted extends TaskState {
  TaskDeleted({super.tasks});
}
