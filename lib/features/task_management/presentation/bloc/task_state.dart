part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState({this.tasks = const []});
  final List<TaskEntity> tasks;

  @override
  List<Object?> get props => [tasks];
}

class TaskInitial extends TaskState {
  const TaskInitial({super.tasks});
}

class TaskLoading extends TaskState {
  const TaskLoading({super.tasks});
}

class TaskLoaded extends TaskState {
  const TaskLoaded({super.tasks});
}

class TaskEventFailed extends TaskState {
  const TaskEventFailed({super.tasks});
}

class TaskAdded extends TaskState {
  const TaskAdded({super.tasks});
}

class TaskDeleted extends TaskState {
  const TaskDeleted({super.tasks});
}
