import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/add_todo_page/add_todo_page.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/todo_item.dart';

class ActivePage extends StatelessWidget {
  static const route = 'active';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (BuildContext context, viewModel) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.todoList.where((element) {
                  return element.isAccomplished == false;
                }).isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      activeToDos,
                      style: textTheme.subtitle1.copyWith(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: viewModel.todoList.where((element) {
                        return element.isAccomplished == false;
                      }).map((todo) {
                        return TodoItem(
                          title: todo.title,
                          description: todo.description,
                          onPressed: () {
                            Future.delayed(
                              Duration(milliseconds: 200),
                                  () {
                                Navigator.of(context).pushNamed(
                                  AddTodo.route,
                                  arguments: AddTodoArguments(todo: todo),
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Container(
                      child: Center(
                        child: Text(
                          activeEmpty,
                          style: textTheme.headline6,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
