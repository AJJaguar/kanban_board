import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/repositories/task_repository.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../di/di.dart';

void main() {
  late TaskRepository taskRepositoryMock;
  late AddTaskUseCase useCase;

  setUp(() {
    taskRepositoryMock = TaskRepositoryMock();
    useCase = AddTaskUseCase(taskRepositoryMock);
  });
  group('add task use case ...', () {
    test('Verify call to [addTask] with the correct data', () async {
      // arrange
      when(
        () => taskRepositoryMock.addTask(
          const AddTaskParam(
            title: 'title',
            description: 'description',
          ),
        ),
      ).thenAnswer(
        (invocation) async => const Right(<TaskEntity>[]),
      );

      // Act
      await useCase(
        const AddTaskParam(
          title: 'title',
          description: 'description',
        ),
      );

      // Assert
      verify(
        () => taskRepositoryMock.addTask(
          const AddTaskParam(
            title: 'title',
            description: 'description',
          ),
        ),
      );
    });
  });
}
