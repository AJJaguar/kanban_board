import 'package:flutter/material.dart';
import 'package:innoscripta_task/common/app_colors.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 37,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
