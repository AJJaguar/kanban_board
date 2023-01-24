import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:innoscripta_task/common/app_focus_remover.dart';
import 'package:innoscripta_task/common/app_routes.dart';
import 'package:innoscripta_task/di/locator.dart';
import 'package:innoscripta_task/features/task_management/presentation/pages/dashboard.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open the box
  // var box = await Hive.openBox('mybox');

  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFocusRemover(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.amber,
            sizeConstraints: BoxConstraints.tightFor(
              width: 70,
              height: 70,
            ),
          ),
        ),
        // initialRoute: Dashboard.route,
        home: const Dashboard(),
      ),
    );
  }
}
