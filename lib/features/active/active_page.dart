import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:todo_app/features/add_todo_page/add_todo_page.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/empty_list_placeholder.dart';
import 'package:todo_app/widgets/header_item.dart';
import 'package:todo_app/widgets/todo_grid_view.dart';
import 'package:todo_app/widgets/todo_item.dart';

class ActivePage extends StatelessWidget {
  static const route = 'active';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (BuildContext context, viewModel) {
        final filteredList = viewModel.todoList.where((element) => element.isAccomplished == false);
        return Scaffold(
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
                        final titleDescriptionNotEmpty = e.description.length > 100 && e.title.isNotEmpty;
                        return StaggeredTile.count(1, titleDescriptionNotEmpty ? 1.50 : 0.75);
                      }).toList(),
                      children: filteredList.map((todo) {
                        return TodoItem(
                          title: todo.title,
                          description: todo.description,
                          onPressed: (context) {
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () => Navigator.of(context).pushNamed(
                                AddTodo.route,
                                arguments: AddTodoArguments(todo: todo),
                              ),
                            );
                          },
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
