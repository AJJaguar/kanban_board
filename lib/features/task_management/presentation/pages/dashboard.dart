import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innoscripta_task/di/locator.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/params/delete_task_param.dart';
import 'package:innoscripta_task/features/task_management/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/dialog_box.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/task_header_widget.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/tasktile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final _showDelete = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(
        locator<AddTaskUseCase>(),
        locator<GetTasksByStatusUseCase>(),
        locator<UpdateTaskUseCase>(),
        locator<DeleteTaskUseCase>(),
      )..add(
          GetTasksByStatusEvent(),
        ),
      child: BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task Added Successfully'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TOdO -------->>>>>>>>>>
                      Expanded(
                        child: DragTarget<TaskEntity>(
                          onAccept: (task) {
                            context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                    param: UpdateTaskParam(
                                      oldTask: task,
                                      newTask: task.copyWith(
                                        status: TaskStatus.todo,
                                      ),
                                    ),
                                  ),
                                );
                          },
                          builder: (context, _, __) => TaskHeader(
                            title: 'Todo',
                            child: Builder(
                              builder: (context) {
                                final todoTasks = state.tasks
                                    .where(
                                      (task) => task.status == TaskStatus.todo,
                                    )
                                    .toList();
                                return SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      todoTasks.length,
                                      (index) {
                                        final task = todoTasks[index];
                                        return Draggable<TaskEntity>(
                                          key: ValueKey(task),
                                          onDragStarted: () {
                                            _showDelete.value = true;
                                          },
                                          onDragEnd: (_) {
                                            _showDelete.value = false;
                                          },
                                          data: task,
                                          feedback: Material(
                                            type: MaterialType.transparency,
                                            child: TaskTile(
                                              taskSubTitle: task.description,
                                              taskTitle: task.title,
                                              timer:
                                                  _convertSecondsToTimeString(
                                                task.seconds,
                                              ),
                                              status: task.status,
                                            ),
                                          ),
                                          childWhenDragging: Opacity(
                                            opacity: 0.5,
                                            child: TaskTile(
                                              taskSubTitle: task.description,
                                              taskTitle: task.title,
                                              timer:
                                                  _convertSecondsToTimeString(
                                                task.seconds,
                                              ),
                                              status: task.status,
                                            ),
                                          ),
                                          child: TaskTile(
                                            taskSubTitle: task.description,
                                            taskTitle: task.title,
                                            timer: _convertSecondsToTimeString(
                                              task.seconds,
                                            ),
                                            status: task.status,
                                            onTick: () {
                                              context.read<TaskBloc>().add(
                                                    UpdateTaskEvent(
                                                      param: UpdateTaskParam(
                                                        oldTask: task,
                                                        newTask: task.copyWith(
                                                          seconds:
                                                              task.seconds + 1,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      /// IN PROGRESS ------>>>>>>>>
                      Expanded(
                        child: DragTarget<TaskEntity>(
                          hitTestBehavior: HitTestBehavior.opaque,
                          onAccept: (task) {
                            context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                    param: UpdateTaskParam(
                                      oldTask: task,
                                      newTask: task.copyWith(
                                        status: TaskStatus.inProgress,
                                      ),
                                    ),
                                  ),
                                );
                          },
                          builder: (context, _, __) => TaskHeader(
                            title: 'In Progress',
                            child: Builder(
                              builder: (context) {
                                final inProgressTasks = state.tasks
                                    .where(
                                      (task) =>
                                          task.status == TaskStatus.inProgress,
                                    )
                                    .toList();
                                return Column(
                                  children: List.generate(
                                    inProgressTasks.length,
                                    (index) {
                                      final task = inProgressTasks[index];
                                      return Draggable<TaskEntity>(
                                        key: ValueKey(task),
                                        data: task,
                                        onDragStarted: () {
                                          _showDelete.value = true;
                                        },
                                        onDragEnd: (_) {
                                          _showDelete.value = false;
                                        },
                                        feedback: Material(
                                          type: MaterialType.transparency,
                                          child: TaskTile(
                                            taskSubTitle: task.description,
                                            taskTitle: task.title,
                                            timer: _convertSecondsToTimeString(
                                              task.seconds,
                                            ),
                                            status: task.status,
                                          ),
                                        ),
                                        childWhenDragging: Opacity(
                                          opacity: 0.5,
                                          child: TaskTile(
                                            taskSubTitle: task.description,
                                            taskTitle: task.title,
                                            timer: _convertSecondsToTimeString(
                                              task.seconds,
                                            ),
                                            status: task.status,
                                          ),
                                        ),
                                        child: TaskTile(
                                          taskSubTitle: task.description,
                                          taskTitle: task.title,
                                          timer: _convertSecondsToTimeString(
                                            task.seconds,
                                          ),
                                          status: task.status,
                                          onTick: () {
                                            context.read<TaskBloc>().add(
                                                  UpdateTaskEvent(
                                                    param: UpdateTaskParam(
                                                      oldTask: task,
                                                      newTask: task.copyWith(
                                                        seconds:
                                                            task.seconds + 1,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      /// DONE -------->>>>>>>
                      Expanded(
                        child: DragTarget<TaskEntity>(
                          onAccept: (task) {
                            context.read<TaskBloc>().add(
                                  UpdateTaskEvent(
                                    param: UpdateTaskParam(
                                      oldTask: task,
                                      newTask: task.copyWith(
                                        status: TaskStatus.done,
                                      ),
                                    ),
                                  ),
                                );
                          },
                          builder: (context, _, __) => TaskHeader(
                            title: 'Done',
                            child: Builder(
                              builder: (context) {
                                final doneTasks = state.tasks
                                    .where(
                                      (task) => task.status == TaskStatus.done,
                                    )
                                    .toList();
                                return Column(
                                  children: List.generate(
                                    doneTasks.length,
                                    (index) {
                                      final task = doneTasks[index];
                                      return Draggable<TaskEntity>(
                                        key: ValueKey(task),
                                        data: task,
                                        onDragStarted: () {
                                          _showDelete.value = true;
                                        },
                                        onDragEnd: (_) {
                                          _showDelete.value = false;
                                        },
                                        feedback: Material(
                                          type: MaterialType.transparency,
                                          child: TaskTile(
                                            taskSubTitle: task.description,
                                            taskTitle: task.title,
                                            timer: _convertSecondsToTimeString(
                                              task.seconds,
                                            ),
                                            status: task.status,
                                          ),
                                        ),
                                        childWhenDragging: Opacity(
                                          opacity: 0.5,
                                          child: TaskTile(
                                            taskSubTitle: task.description,
                                            taskTitle: task.title,
                                            timer: _convertSecondsToTimeString(
                                              task.seconds,
                                            ),
                                            status: task.status,
                                          ),
                                        ),
                                        child: TaskTile(
                                          taskSubTitle: task.description,
                                          taskTitle: task.title,
                                          timer: _convertSecondsToTimeString(
                                            task.seconds,
                                          ),
                                          status: task.status,
                                          onTick: () {
                                            context.read<TaskBloc>().add(
                                                  UpdateTaskEvent(
                                                    param: UpdateTaskParam(
                                                      oldTask: task,
                                                      newTask: task.copyWith(
                                                        seconds:
                                                            task.seconds + 1,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _showDelete,
                    builder: (context, showDelete, child) {
                      return Visibility(
                        visible: showDelete,
                        child: Positioned(
                          left: -65,
                          bottom: -65,
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.red.withOpacity(0.5),
                            child: DragTarget<TaskEntity>(
                              onAccept: (task) {
                                context.read<TaskBloc>().add(
                                      DeleteTaskEvent(
                                        param: DeleteTaskParam(
                                          task: task,
                                        ),
                                      ),
                                    );
                              },
                              builder: (context, _, __) => child!,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 55,
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog<dynamic>(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<TaskBloc>(),
                      child: DialogBox(
                        onSave: () {},
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                CupertinoIcons.add,
                size: 35,
              ),
            ),
          );
        },
      ),
    );
  }

  String _convertSecondsToTimeString(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}'
        ': ${(seconds % 60).toString().padLeft(2, '0')}';
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
  });
  final TextEditingController? controller;
  final String hintText;
  final int? maxLines;
  final FormFieldValidator<String?>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
      ),
    );
  }
}
