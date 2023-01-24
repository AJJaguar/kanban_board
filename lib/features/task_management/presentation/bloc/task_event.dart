part of 'task_bloc.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  AddTaskEvent({required this.param});
  final AddTaskParam param;
}

class GetTasksByStatusEvent extends TaskEvent {
  GetTasksByStatusEvent({this.param});
  final GetTasksParam? param;
}

class UpdateTaskEvent extends TaskEvent {
  UpdateTaskEvent({required this.param});
  final UpdateTaskParam param;
}

class DeleteTaskEvent extends TaskEvent {
  DeleteTaskEvent({required this.param});
  final DeleteTaskParam param;
}
