import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uuid/uuid.dart';

import '../../models/todo.dart';
import '../../state/app_state/actions/todo_actions.dart';
import '../../state/app_state/app_state.dart';
import '../../utils/constants.dart';
import '../../widgets/empty_list_placeholder.dart';
import '../../widgets/header_item.dart';
import '../../widgets/todo_grid_view.dart';
import '../../widgets/todo_item.dart';
import '../add_todo_page/add_todo_page.dart';
import '../home_page/home_page.dart';

class ActivePage extends StatelessWidget {
  static const route = 'active';

  Widget displayFloatingButton(BuildContext context, {bool isActivePage}) {
    return isActivePage
        ? FloatingActionButton(
            onPressed: () => _navigateToAddTodo(context, null),
            tooltip: newTodo,
            child: const Icon(Icons.add),
          )
        : null;
  }

  Future<void> _navigateToAddTodo(BuildContext context, Todo todo) async {
    final result = await Navigator.of(context).pushNamed(AddTodo.route, arguments: AddTodoArguments(todo: todo))
        as HomePageArguments;
    final title = result.title;
    final description = result.description;
    final isAccomplished = result.isAccomplished;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (result.todo == null && (title.isNotEmpty || description.isNotEmpty)) {
          StoreProvider.dispatch<AppState>(
            context,
            AddTodoAction(
              todo: Todo(
                id: Uuid().v1(),
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
      builder: (BuildContext context, viewModel) {
        final filteredList = viewModel.todoList.where((element) => element.isAccomplished == false);
        final isActivePage = viewModel.pageIndex == 0;
        return Scaffold(
          floatingActionButton: displayFloatingButton(
            context,
            isActivePage: isActivePage,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filteredList.isNotEmpty) ...[
                  HeaderItem(headerTitle: activeToDos),
                  Expanded(
                    child: TodoGridView(
                      staggeredTiles: filteredList.map((e) {
                        return StaggeredTile.count(1, e.description.length > 100 ? 1.75 : 0.75);
                      }).toList(),
                      children: filteredList.map((todo) {
                        return TodoItem(
                          title: todo.title,
                          description: todo.description,
                          onPressed: (context) => HomePage.navigateToUpdateTodo(context, todo),
                        );
                      }).toList(),
                    ),
                  ),
                ] else ...[
                  EmptyListPlaceHolder(placeHolderTitle: activeEmpty),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
