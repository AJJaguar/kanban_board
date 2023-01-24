import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/task_header_widget.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/tasktile.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Center(
              child: TaskHeader(
                title: 'Completed Tasks',
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
                            return TaskTile(
                              description: task.description,
                              taskTitle: task.title,
                              timer: 'TIME SPENT\n'
                                  '${_convertSecondsToTimeString(task.seconds)}\n\n'
                                  'COMPLETED AT\n'
                                  '${task.completedAt.toString()}',
                              status: task.status,
                              onTick: () {
                                context.read<TaskBloc>().add(
                                      UpdateTaskEvent(
                                        param: UpdateTaskParam(
                                          oldTask: task,
                                          newTask: task.copyWith(
                                            seconds: task.seconds + 1,
                                          ),
                                        ),
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _convertSecondsToTimeString(int seconds) {
    return '${(seconds ~/ 60).toString().padLeft(2, '0')}'
        ': ${(seconds % 60).toString().padLeft(2, '0')}';
  }
}
