import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innoscripta_task/common/app_colors.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    super.key,
    required this.taskTitle,
    required this.taskSubTitle,
    required this.timer,
    required this.status,
    this.onTick,
  });
  final String taskTitle;
  final String taskSubTitle;
  final String timer;
  final TaskStatus status;
  final VoidCallback? onTick;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  Timer? _timer;

  void _initTimer() {
    if (widget.status == TaskStatus.inProgress) {
      _timer = Timer.periodic(
        const Duration(milliseconds: 1000),
        (timer) {
          widget.onTick?.call();
        },
      );
    }
  }

  @override
  void initState() {
    // _timer = Timer.periodic(
    //   const Duration(milliseconds: 1000),
    //   (timer) {
    //     print('here ${timer.tick}');
    //     if (widget.status == TaskStatus.inProgress) {
    //       widget.onTick?.call();
    //     }
    //   },
    // );
    _initTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _getColorFromStatus,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.taskTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.taskSubTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.timer,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Color get _getColorFromStatus {
    switch (widget.status) {
      case TaskStatus.todo:
        return AppColors.red;
      case TaskStatus.inProgress:
        return AppColors.periwinkle;
      case TaskStatus.done:
        return AppColors.mint;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
