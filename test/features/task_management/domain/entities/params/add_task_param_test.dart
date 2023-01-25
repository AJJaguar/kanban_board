import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';

void main() {
  group('add task param ...', () {
    const addTaskParam =
        AddTaskParam(title: 'title', description: 'description');

    test('verify that two [AddTaskParam] with the same data are equal', () {
      expect(
        addTaskParam,
         const AddTaskParam(title: 'title', description: 'description'),
      );
    });

    test('verify that [toJson] return the right json data', () {
      expect(addTaskParam.toJson(), {
        'name': 'title',
        'description': 'description',
      });
    });
  });
}
