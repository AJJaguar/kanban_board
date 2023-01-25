part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class AddTaskEvent extends TaskEvent {
  const AddTaskEvent({required this.param});
  final AddTaskParam param;

  @override
  List<Object?> get props => [param];
}

class GetTasksByStatusEvent extends TaskEvent {
  const GetTasksByStatusEvent({this.param});
  final GetTasksParam? param;

  @override
  List<Object?> get props => [param];
}

class UpdateTaskEvent extends TaskEvent {
  const UpdateTaskEvent({required this.param});
  final UpdateTaskParam param;

  @override
  List<Object?> get props => [param];
}

class DeleteTaskEvent extends TaskEvent {
  const DeleteTaskEvent({required this.param});
  final DeleteTaskParam param;

  @override
  List<Object?> get props => [param];
}

class DownloadTaskEvent extends TaskEvent {
  const DownloadTaskEvent();

  @override
  List<Object?> get props => [];
}
