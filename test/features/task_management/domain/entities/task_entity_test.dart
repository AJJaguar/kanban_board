import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

void main() {
  group('task entity ...', () {
    const task = TaskEntity(
      status: TaskStatus.done,
      title: 'title',
      description: 'description',
      seconds: 2,
    );
    test('Test for entity equality', () {
      expect(
        task,
        const TaskEntity(
          status: TaskStatus.done,
          title: 'title',
          description: 'description',
          seconds: 2,
        ),
      );
    });

    test(
      'when [copyWith] is called with a nes description, '
      'task entity description should changed while keeping the '
      'rest of the data ',
      () {
        expect(
        task.copyWith(description: 'New Description'),
        const TaskEntity(
          status: TaskStatus.done,
          title: 'title',
          description: 'New Description',
          seconds: 2,
        ),
      );
      },
    );
  });
}
