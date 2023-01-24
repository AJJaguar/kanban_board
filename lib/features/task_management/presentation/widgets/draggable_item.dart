import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/tasktile.dart';

class DraggableItem extends StatelessWidget {
  const DraggableItem({
    super.key,
    required this.task,
    required this.onDragStarted,
    required this.onDragEnd,
  });
  final VoidCallback onDragStarted;
  final void Function(DraggableDetails) onDragEnd;
  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    return Draggable<TaskEntity>(
      key: ValueKey(task),
      data: task,
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
      feedback: Material(
        type: MaterialType.transparency,
        child: TaskTile(
          description: task.description,
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
          description: task.description,
          taskTitle: task.title,
          timer: _convertSecondsToTimeString(
            task.seconds,
          ),
          status: task.status,
        ),
      ),
      child: TaskTile(
        description: task.description,
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
                      seconds: task.seconds + 1,
                    ),
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
