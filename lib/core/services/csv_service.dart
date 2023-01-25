import 'package:csv/csv.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';

mixin CSVService {
  Future<void> saveTaskAsCSV(List<TaskEntity> tasks);
}

class CSVServiceImpl implements CSVService {
  const CSVServiceImpl(this.listToCsvConverter);
  final ListToCsvConverter listToCsvConverter;
  @override
  Future<void> saveTaskAsCSV(List<TaskEntity> tasks) {
    //ToDo -- Work here ------
    throw UnimplementedError();
  }
}
