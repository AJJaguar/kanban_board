import 'dart:io';

import 'package:csv/csv.dart';
import 'package:innoscripta_task/features/task_management/domain/entities/task_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

mixin CSVService {
  Future<void> saveTaskAsCSV(List<TaskEntity> tasks);
}

class CSVServiceImpl implements CSVService {
  const CSVServiceImpl(this.listToCsvConverter);
  final ListToCsvConverter listToCsvConverter;
  @override
  Future<void> saveTaskAsCSV(List<TaskEntity> tasks) async {
    if (await Permission.storage.request().isGranted) {
      final dir = await getApplicationDocumentsDirectory();

      final appDocumentsPath = dir.path;
      final filePath = '$appDocumentsPath/file.csv';
      final file = File(filePath);
      final tasksList = List<List<dynamic>>.empty(growable: true);
      for (var i = 0; i < tasks.length; i++) {
        final tempList = List<dynamic>.empty(growable: true);
        tempList.add(tasks[i].title);
        tempList.add(tasks[i].description);
        tempList.add(tasks[i].seconds);
        tempList.add(tasks[i].status);
        tasksList.add(tempList);
      }

      final csv = const ListToCsvConverter().convert(tasksList);

      await file.writeAsString(csv);
    }
  }
}
