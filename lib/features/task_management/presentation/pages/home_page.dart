import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/delete_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/draggable_item.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/task_header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _showDelete = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
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
        return Stack(
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
                                  return DraggableItem(
                                    task: task,
                                    onDragStarted: () =>
                                        _showDelete.value = true,
                                    onDragEnd: (_) => _showDelete.value = false,
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
                                (task) => task.status == TaskStatus.inProgress,
                              )
                              .toList();
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                inProgressTasks.length,
                                (index) {
                                  final task = inProgressTasks[index];
                                  return DraggableItem(
                                    task: task,
                                    onDragStarted: () =>
                                        _showDelete.value = true,
                                    onDragEnd: (_) => _showDelete.value = false,
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
                                  completedAt: DateTime.now(),
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
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                doneTasks.length,
                                (index) {
                                  final task = doneTasks[index];
                                  return DraggableItem(
                                    task: task,
                                    onDragStarted: () =>
                                        _showDelete.value = true,
                                    onDragEnd: (_) => _showDelete.value = false,
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
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _showDelete,
              builder: (context, showDelete, child) {
                return Visibility(
                  visible: showDelete,
                  child: Positioned(
                    left: -75,
                    bottom: -75,
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
        );
      },
    );
  }
}
