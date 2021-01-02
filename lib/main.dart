import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'features/home_page/home_page.dart';
import 'state/app_state/app_state.dart';
import 'utils/app_router.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.initState());
  runApp(TodoApp(store: store));
}

class TodoApp extends StatelessWidget {
  final Store<AppState> store;

  const TodoApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter To Do',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: HomePage.route,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
