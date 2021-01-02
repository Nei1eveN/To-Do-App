import 'package:flutter/material.dart';

import '../features/accomplished/accomplished_page.dart';
import '../features/active/active_page.dart';
import '../features/add_todo_page/add_todo_page.dart';
import '../features/home_page/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => HomePage());
      case ActivePage.route:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => ActivePage());
      case AccomplishedPage.route:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => AccomplishedPage());
      case AddTodo.route:
        final args = settings.arguments as AddTodoArguments;
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => AddTodo(args: args));
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
