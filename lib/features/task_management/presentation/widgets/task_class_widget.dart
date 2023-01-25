import 'package:flutter/material.dart';
import 'package:innoscripta_task/common/app_colors.dart';
import 'package:innoscripta_task/common/app_text_styles.dart';

class TaskClass extends StatelessWidget {
  const TaskClass({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      // height: 648,
      // width: 368,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.grey,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.taskClass,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
