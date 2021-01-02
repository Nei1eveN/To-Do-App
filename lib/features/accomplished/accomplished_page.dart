import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../state/app_state/app_state.dart';
import '../../utils/constants.dart';
import '../../widgets/empty_list_placeholder.dart';
import '../../widgets/header_item.dart';
import '../../widgets/todo_grid_view.dart';
import '../../widgets/todo_item.dart';
import '../home_page/home_page.dart';

class AccomplishedPage extends StatelessWidget {
  static const route = 'accomplished';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (context, viewModel) {
        final filteredList = viewModel.todoList.where((element) => element.isAccomplished == true);
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filteredList.isNotEmpty) ...[
                  HeaderItem(headerTitle: accomplishedToDos),
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
                  EmptyListPlaceHolder(placeHolderTitle: accomplishedEmpty),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
