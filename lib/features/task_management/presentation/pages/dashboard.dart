import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innoscripta_task/di/locator.dart';

import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';

import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:innoscripta_task/features/task_management/presentation/pages/history_page.dart';
import 'package:innoscripta_task/features/task_management/presentation/pages/home_page.dart';
import 'package:innoscripta_task/features/task_management/presentation/widgets/dialog_box.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const route = '/dashboard';

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TaskBloc(
          locator<AddTaskUseCase>(),
          locator<GetTasksByStatusUseCase>(),
          locator<UpdateTaskUseCase>(),
          locator<DeleteTaskUseCase>(),
        )..add(
            GetTasksByStatusEvent(),
          ),
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                body: const TabBarView(
                  children: [
                    HomePage(),
                    HistoryPage(),
                  ],
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
                    size: 40,
                  ),
                ),
                bottomNavigationBar: const TabBar(
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                      text: 'Home',
                    ),
                    Tab(
                      icon: Icon(Icons.history),
                      text: 'History',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
