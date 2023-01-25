import 'package:csv/csv.dart';
import 'package:get_it/get_it.dart';
import 'package:innoscripta_task/core/services/csv_service.dart';
import 'package:innoscripta_task/core/services/task_storage_service.dart';
import 'package:innoscripta_task/features/task_management/data/datasources/task_data_source.dart';
import 'package:innoscripta_task/features/task_management/data/repositories/task_repository_impl.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton(() => AddTaskUseCase(locator()))
    ..registerLazySingleton(() => GetTasksByStatusUseCase(locator()))
    ..registerLazySingleton(() => UpdateTaskUseCase(locator()))
    ..registerLazySingleton(() => DeleteTaskUseCase(locator()))
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(
        locator(),
      ),
    )
    ..registerLazySingleton<CSVService>(
      () => const CSVServiceImpl(
        ListToCsvConverter(),
      ),
    )
    ..registerLazySingleton<TaskDataSource>(
      () => LocalTaskDataSourceImpl(
        ListTaskStorageService(),
      ),
    )
    ..registerLazySingleton<TaskStorageService>(
      ListTaskStorageService.new,
    );
}
