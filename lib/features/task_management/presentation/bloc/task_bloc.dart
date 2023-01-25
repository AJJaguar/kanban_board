import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/delete_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/get_tasks_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(
    this._addTaskUseCase,
    this._getTaskUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(const TaskInitial()) {
    on<AddTaskEvent>(_onAddTaskEvent);
    on<GetTasksByStatusEvent>(_onGetTasksEvent);
    on<UpdateTaskEvent>(_onUpdateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  final AddTaskUseCase _addTaskUseCase;
  final GetTasksByStatusUseCase _getTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  void _onAddTaskEvent(AddTaskEvent event, Emitter<TaskState> emit) {
    emit(const TaskLoading());
    _addTaskUseCase(event.param).then(
      (value) => value.fold(
        (failure) => emit(
          TaskEventFailed(tasks: state.tasks),
        ),
        (tasks) => emit(
          TaskAdded(tasks: tasks),
        ),
      ),
    );
  }

  void _onGetTasksEvent(GetTasksByStatusEvent event, Emitter<TaskState> emit) {
    emit(const TaskLoading());
    _getTaskUseCase(event.param).then(
      (value) => value.fold(
        (failure) => emit(
          TaskEventFailed(tasks: state.tasks),
        ),
        (tasks) => emit(
          TaskLoaded(tasks: tasks),
        ),
      ),
    );
  }

  void _onUpdateTaskEvent(UpdateTaskEvent event, Emitter<TaskState> emit) {
    emit(const TaskLoading());
    _updateTaskUseCase(event.param).then(
      (value) => value.fold(
        (failure) => emit(
          TaskEventFailed(tasks: state.tasks),
        ),
        (tasks) => emit(
          TaskLoaded(tasks: tasks),
        ),
      ),
    );
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) {
    emit(const TaskLoading());
    _deleteTaskUseCase(event.param).then(
      (value) => value.fold(
        (failure) => emit(
          TaskEventFailed(tasks: state.tasks),
        ),
        (tasks) => emit(
          TaskLoaded(tasks: tasks),
        ),
      ),
    );
  }
}
