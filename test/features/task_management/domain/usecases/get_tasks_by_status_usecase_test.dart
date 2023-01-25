import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/get_tasks_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/di.dart';

void main() {
  late TaskRepository taskRepositoryMock;
  late GetTasksByStatusUseCase useCase;

  setUp(() {
    taskRepositoryMock = TaskRepositoryMock();
    // useCase = GetTasksByStatusUseCase(taskRepositoryMock);
    useCase = GetTasksByStatusUseCase(taskRepositoryMock);
  });

  group('get task by status use case ...', () {
    test('Verify call to [getTask] with the correct data', () async {
      // arrange
      when(
        () => taskRepositoryMock.getTasksByStatus(
          const GetTasksParam(
            status: TaskStatus.done,
          ),
        ),
      ).thenAnswer(
        (invocation) async => const Right(<TaskEntity>[]),
      );

      // Act
      await useCase(
        const GetTasksParam(
          status: TaskStatus.done,
        ),
      );

      // Assert
      verify(
        () => taskRepositoryMock.getTasksByStatus(
          const GetTasksParam(
            status: TaskStatus.done,
          ),
        ),
      );
    });
  });
}
