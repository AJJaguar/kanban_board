import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/update_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/di.dart';

void main() {
  late TaskRepository taskRepositoryMock;
  late UpdateTaskUseCase useCase;

  setUp(() {
    taskRepositoryMock = TaskRepositoryMock();
    useCase = UpdateTaskUseCase(taskRepositoryMock);
  });

  const task = TaskEntity(
    status: TaskStatus.todo,
    title: 'title',
    description: 'description',
    seconds: 2,
  );
  group('update task use case ...', () {
    test('Verify call to [update task] with the correct data', () async {
      // arrange
      when(
        () => taskRepositoryMock.updateTask(
          UpdateTaskParam(
            oldTask: task,
            newTask: task,
          ),
        ),
      ).thenAnswer(
        (invocation) async => const Right(<TaskEntity>[]),
      );

      // Act
      await useCase(
        UpdateTaskParam(
          oldTask: task,
          newTask: task,
        ),
      );

      // Assert
      verify(
        () => taskRepositoryMock.updateTask(
          UpdateTaskParam(
            oldTask: task,
            newTask: task,
          ),
        ),
      );
    });
  });
}
