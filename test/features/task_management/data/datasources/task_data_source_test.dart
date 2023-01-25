import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/core/services/task_storage_service.dart';
import 'package:innoscripta_task/features/task_management/data/datasources/task_data_source.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:mocktail/mocktail.dart';

class TaskStorageServiceMock extends Mock implements TaskStorageService {}

void main() {
  late TaskStorageService taskStorageService;
  late TaskDataSource taskDataSource;

  setUpAll(() {
    taskStorageService = TaskStorageServiceMock();
    taskDataSource = LocalTaskDataSourceImpl(taskStorageService);
  });
  group('task data source ...', () {
    test(
      'verify call to [taskStorageService.addTask] '
      'when [addTask] is called ',
      () async {
        // arrange
        when(
          () => taskStorageService.addTask(
            const TaskEntity(
              status: TaskStatus.todo,
              title: 'title',
              description: 'description',
              seconds: 0,
            ),
          ),
        ).thenAnswer((invocation) async => <TaskEntity>[]);
        // act
        await taskDataSource.addTask(
          const AddTaskParam(title: 'title', description: 'description'),
        );
        // assert
        verify(
          () => taskStorageService.addTask(
            const TaskEntity(
              status: TaskStatus.todo,
              title: 'title',
              description: 'description',
              seconds: 0,
            ),
          ),
        );
      },
    );
  });
}
