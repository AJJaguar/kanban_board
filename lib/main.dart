import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:innoscripta_task/common/app_focus_remover.dart';
import 'package:innoscripta_task/common/app_routes.dart';
import 'package:innoscripta_task/core/bloc/local_bloc/localization_bloc.dart';
import 'package:innoscripta_task/di/locator.dart';
import 'package:innoscripta_task/features/task_management/presentation/pages/dashboard.dart';

void main() async {
  // Step 2
  WidgetsFlutterBinding.ensureInitialized();
  // Step 3
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFocusRemover(
      child: BlocProvider(
        create: (context) => LocalizationBloc(),
        child: BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            return MaterialApp(
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
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(state.selectedLocal),
            );
          },
        ),
      ),
    );
  }
}
