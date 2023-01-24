import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:innoscripta_task/features/task_management/presentation/pages/dashboard.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Dashboard.route:
        return _route(const Dashboard());
      default:
        return _route(
          const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }

  static PageRoute<dynamic> _route(Widget child) {
    return CupertinoPageRoute(builder: (context) => child);
  }
}
