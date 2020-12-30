import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/add_todo_page/add_todo_page.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/tile_item.dart';

import 'features/accomplished/accomplished_page.dart';
import 'features/active/active_page.dart';
import 'models/todo.dart';
import 'state/app_state/actions/screen_changing_actions.dart';

class MainViewModel extends BaseModel<AppState> {
  String title;
  int pageIndex;
  List<Todo> todoList;

  MainViewModel();

  /// must have super(equals: [variables here])
  /// https://github.com/marcglasberg/async_redux/issues/69#issuecomment-626248496
  MainViewModel.build({this.title, this.pageIndex, this.todoList}) : super(equals: [title, pageIndex, todoList]);

  @override
  BaseModel fromStore() =>
      MainViewModel.build(title: state.title, pageIndex: state.pageIndex, todoList: state.todoList);
}

void main() {
  final store = Store<AppState>(initialState: AppState.initState());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter To Do',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: MyHomePage.route,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const route = 'home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget displayFloatingButton({bool isActivePage}) {
    return isActivePage
        ? FloatingActionButton(
            onPressed: () => _navigateToAddTodo(null),
            tooltip: newTodo,
            child: const Icon(Icons.add),
          )
        : null;
  }

  void _navigateToAddTodo(Todo todo) {
    Future.delayed(
      const Duration(milliseconds: 200),
      () => Navigator.of(context).pushNamed(AddTodo.route, arguments: AddTodoArguments(todo: todo)),
    );
  }

  /// Dispatches actions when a TileItem is tapped.
  ///
  /// * [newTitle] changes title; to be passed on [ChangeScreenAction]
  /// * [newIndex] changes current index to identify which screen will be shown; to be passed on [ChangeScreenAction]
  void _dispatchAction(String newTitle, int newIndex) {
    StoreProvider.dispatch(context, ChangeScreenAction(title: newTitle, pageIndex: newIndex));
    Future.delayed(const Duration(milliseconds: 200), () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (context, viewModel) {
        final pageIndex = viewModel.pageIndex;
        final isActivePage = pageIndex == 0;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              viewModel.title,
              style: const TextStyle(fontSize: 16.0),
            ),
            backgroundColor: isActivePage ? Colors.blue : Colors.red,
          ),
          body: isActivePage ? ActivePage() : AccomplishedPage(),
          floatingActionButton: displayFloatingButton(isActivePage: isActivePage),
          drawer: Drawer(
            child: ListView(
              children: [
                const SizedBox(height: kToolbarHeight),
                TileItem(
                  iconData: Icons.lightbulb_outline,
                  title: active,
                  onTap: (context) => _dispatchAction(active, 0),
                  focusColor: Colors.blue[600],
                  isSelected: isActivePage,
                ),
                TileItem(
                  iconData: Icons.done_all_outlined,
                  title: accomplished,
                  onTap: (context) => _dispatchAction(accomplished, 1),
                  focusColor: Colors.red[600],
                  isSelected: !isActivePage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MyHomePage.route:
        return MaterialPageRoute<dynamic>(builder: (BuildContext context) => MyHomePage());
        break;
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
