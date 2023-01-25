import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:innoscripta_task/core/bloc/local_bloc/localization_bloc.dart';
import 'package:innoscripta_task/core/services/csv_service.dart';
import 'package:innoscripta_task/di/locator.dart';
import 'package:innoscripta_task/features/task_management/data/models/language_model.dart';
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
    final local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => TaskBloc(
          locator<AddTaskUseCase>(),
          locator<GetTasksByStatusUseCase>(),
          locator<UpdateTaskUseCase>(),
          locator<DeleteTaskUseCase>(),
          locator<CSVService>(),
        )..add(
            const GetTasksByStatusEvent(),
          ),
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(local.dashboard),
                  actions: [
                    IconButton(
                      onPressed: () => context.read<TaskBloc>().add(
                            const DownloadTaskEvent(),
                          ),
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      child: DropdownButton<Language>(
                        onChanged: (Language? language) {
                          context.read<LocalizationBloc>().add(
                                ChangeLocalizationEvent(
                                  language?.languageCode ?? 'en',
                                ),
                              );
                        },
                        icon: const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                              (e) => DropdownMenuItem<Language>(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
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
                bottomNavigationBar: TabBar(
                  indicatorWeight: 1,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.home),
                      text: AppLocalizations.of(context)!.home,
                    ),
                    Tab(
                      icon: const Icon(Icons.history),
                      text: AppLocalizations.of(context)!.history,
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
