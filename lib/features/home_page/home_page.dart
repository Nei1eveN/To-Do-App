import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/add_todo_page/add_todo_page.dart';
import 'package:todo_app/state/app_state/actions/todo_actions.dart';

import '../../models/todo.dart';
import '../../state/app_state/actions/screen_changing_actions.dart';
import '../../state/app_state/app_state.dart';
import '../../utils/constants.dart';
import '../../widgets/tile_item.dart';
import '../accomplished/accomplished_page.dart';
import '../active/active_page.dart';

class HomePageArguments {
  final Todo todo;
  final String title;
  final String description;
  final bool isAccomplished;

  HomePageArguments(this.todo, {this.title, this.description, this.isAccomplished});
}

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

class HomePage extends StatelessWidget {
  static const route = 'home';

  /// Dispatches actions when a TileItem is tapped.
  ///
  /// * [newTitle] changes title; to be passed on [ChangeScreenAction]
  /// * [newIndex] changes current index to identify which screen will be shown; to be passed on [ChangeScreenAction]
  void _dispatchAction(BuildContext context, String newTitle, int newIndex) {
    StoreProvider.dispatch(context, ChangeScreenAction(title: newTitle, pageIndex: newIndex));
    Future.delayed(const Duration(milliseconds: 200), () => Navigator.pop(context));
  }

  static Future<void> navigateToUpdateTodo(BuildContext context, Todo todo) async {
    final result = await Navigator.of(context).pushNamed(
      AddTodo.route,
      arguments: AddTodoArguments(todo: todo),
    ) as HomePageArguments;
    final resultTodo = result.todo;
    final title = result.title;
    final description = result.description;
    final isAccomplished = result.isAccomplished;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (resultTodo != null && (title.isNotEmpty || description.isNotEmpty)) {
          StoreProvider.dispatch<AppState>(
            context,
            UpdateTodoAction(
              todo: Todo(
                id: resultTodo.id,
                title: title,
                description: description,
                isAccomplished: isAccomplished,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (context, viewModel) {
        final isActivePage = viewModel.pageIndex == 0;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              viewModel.title,
              style: const TextStyle(fontSize: 16.0),
            ),
            backgroundColor: isActivePage ? Colors.blue : Colors.red,
          ),
          body: isActivePage ? ActivePage() : AccomplishedPage(),
          drawer: Drawer(
            child: ListView(
              children: [
                const SizedBox(height: kToolbarHeight),
                TileItem(
                  iconData: Icons.lightbulb_outline,
                  title: active,
                  onTap: (context) => _dispatchAction(context, active, 0),
                  focusColor: Colors.blue[600],
                  isSelected: isActivePage,
                ),
                TileItem(
                  iconData: Icons.done_all_outlined,
                  title: accomplished,
                  onTap: (context) => _dispatchAction(context, accomplished, 1),
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
