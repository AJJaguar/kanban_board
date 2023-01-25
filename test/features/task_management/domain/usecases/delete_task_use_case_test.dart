import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/delete_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/di.dart';

void main() {
  late TaskRepository taskRepositoryMock;
  late DeleteTaskUseCase useCase;

  setUp(() {
    taskRepositoryMock = TaskRepositoryMock();
    useCase = DeleteTaskUseCase(taskRepositoryMock);
  });

  const task = TaskEntity(
    status: TaskStatus.todo,
    title: 'title',
    description: 'description',
    seconds: 2,
  );
  group('delete task use case ...', () {
    test('Verify call to [addTask] with the correct data', () async {
      // arrange
      when(
        () => taskRepositoryMock.deleteTasks(
          const DeleteTaskParam(
            task: task,
          ),
        ),
      ).thenAnswer(
        (invocation) async => const Right(<TaskEntity>[]),
      );

      // Act
      await useCase(
         const DeleteTaskParam(
            task: task,
          ),
      );

      // Assert
      verify(
        () => taskRepositoryMock.deleteTasks(
           const DeleteTaskParam(
            task: task,
          ),
        ),
      );
    });
  });
}
