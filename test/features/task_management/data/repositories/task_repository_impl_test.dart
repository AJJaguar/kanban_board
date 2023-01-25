import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/core/error/failure.dart';
import 'package:innoscripta_task/features/task_management/data/datasources/task_data_source.dart';
import 'package:innoscripta_task/features/task_management/data/repositories/task_repository_impl.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:mocktail/mocktail.dart';

class TaskDataSourceMock extends Mock implements TaskDataSource {}

void main() {
  late TaskDataSource taskDataSource;
  late TaskRepository repository;

  setUpAll(() {
    taskDataSource = TaskDataSourceMock();
    repository = TaskRepositoryImpl(taskDataSource);
  });
  group('task repository impl ...', () {
    group('add task ...', () {
      test(
        'verify that when [addTask] returns without any error the right '
        'side of either is returned',
        () async {
          // arrange
          when(
            () => taskDataSource.addTask(
              const AddTaskParam(title: 'title', description: 'description'),
            ),
          ).thenAnswer((invocation) async =>  const <TaskEntity>[]);

          // act
          final result = await repository.addTask(
            const AddTaskParam(title: 'title', description: 'description'),
          );

          // assert
          expect(
            result,
            const Right<Failure, List<TaskEntity>>(<TaskEntity>[]),
          );
        },
      );
      test(
        'verify that when [addTask] returns with any error the left '
        'side of either is returned',
        () async {
          // arrange
          when(
            () => taskDataSource.addTask(
              const AddTaskParam(title: 'title', description: 'description'),
            ),
          ).thenAnswer((invocation) async => throw Exception());

          // act
          final result = await repository.addTask(
            const AddTaskParam(title: 'title', description: 'description'),
          );

          // assert
          expect(
            result,
            const Left<Failure, List<TaskEntity>>(
              TaskFailure('Failed to add task'),
            ),
          );
        },
      );
    });
    group('delete task ...', () {});
    group('update task ...', () {});
    group('get task ...', () {});
  });
}
