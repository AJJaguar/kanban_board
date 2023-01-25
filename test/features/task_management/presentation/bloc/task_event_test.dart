import 'package:flutter_test/flutter_test.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/params/add_task_param.dart';
import 'package:innoscripta_task/features/task_management/presentation/bloc/task_bloc.dart';

void main() {
  group('task event ...', () {
    test('verify object equality for [AddTaskEvent]', () {
      expect(
        const AddTaskEvent(
          param: AddTaskParam(
            description: 'description',
            title: 'title',
          ),
        ),
        const AddTaskEvent(
          param: AddTaskParam(
            title: 'title',
            description: 'description',
          ),
        ),
      );
    });
  });
}
