import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/core/error/failure.dart';
import 'package:innoscripta_task/core/services/csv_service.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/add_task_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/delete_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/get_tasks_by_status_usecase.dart';
import 'package:innoscripta_task/features/task_management/domain/usecases/update_task_use_case.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:mocktail/mocktail.dart';

class AddTaskUseCaseMock extends Mock implements AddTaskUseCase {}

class UpdateTaskUseCaseMock extends Mock implements UpdateTaskUseCase {}

class GetTasksByStatusUseCaseMock extends Mock
    implements GetTasksByStatusUseCase {}

class DeleteTaskUseCaseMock extends Mock implements DeleteTaskUseCase {}

class CSVServiceMock extends Mock implements CSVService {}

void main() {
  late AddTaskUseCase addTaskUseCase;
  late UpdateTaskUseCase updateTaskUseCase;
  late GetTasksByStatusUseCase getTasksByStatusUseCase;
  late DeleteTaskUseCase deleteTaskUseCase;
  late CSVService csvService;

  setUpAll(() {
    addTaskUseCase = AddTaskUseCaseMock();
    updateTaskUseCase = UpdateTaskUseCaseMock();
    deleteTaskUseCase = DeleteTaskUseCaseMock();
    getTasksByStatusUseCase = GetTasksByStatusUseCaseMock();
    csvService = CSVServiceMock();
  });
  group(
    'task bloc ...',
    () {
      test('Verify that bloc starts with the initial state', () {
        final taskBloc = TaskBloc(
          addTaskUseCase,
          getTasksByStatusUseCase,
          updateTaskUseCase,
          deleteTaskUseCase,
          csvService,
        );
        expect(taskBloc.state, const TaskInitial());
        taskBloc.close();
      });

      group('AddTaskEvent ...', () {
        blocTest<TaskBloc, TaskState>(
          'Verify that [TaskAdded] state is emitted when [addTaskUseCase] '
          'completes without an error',
          setUp: () => when(
            () => addTaskUseCase(
              const AddTaskParam(
                title: 'title',
                description: 'description',
              ),
            ),
          ).thenAnswer((invocation) async => const Right(<TaskEntity>[])),
          build: () => TaskBloc(
            addTaskUseCase,
            getTasksByStatusUseCase,
            updateTaskUseCase,
            deleteTaskUseCase,
            csvService,
          )..add(
              const AddTaskEvent(
                param: AddTaskParam(
                  title: 'title',
                  description: 'description',
                ),
              ),
            ),
          expect: () => const [
            TaskLoading(),
            TaskAdded(),
          ],
        );

        blocTest<TaskBloc, TaskState>(
          'Verify that [TaskAdded] state is emitted when [addTaskUseCase] '
          'completes without an error',
          setUp: () => when(
            () => addTaskUseCase(
              const AddTaskParam(
                title: 'title',
                description: 'description',
              ),
            ),
          ).thenAnswer(
            (invocation) async => const Left(
              TaskFailure('message'),
            ),
          ),
          build: () => TaskBloc(
            addTaskUseCase,
            getTasksByStatusUseCase,
            updateTaskUseCase,
            deleteTaskUseCase,
            csvService,
          )..add(
              const AddTaskEvent(
                param: AddTaskParam(
                  title: 'title',
                  description: 'description',
                ),
              ),
            ),
          expect: () => const [
            TaskLoading(),
            TaskEventFailed(),
          ],
        );
      });
    },
  );
}
