import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/add_todo_page/add_todo_page.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/todo_item.dart';

class AccomplishedPage extends StatelessWidget {
  static const route = 'accomplished';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StoreConnector<AppState, MainViewModel>(
        model: MainViewModel(),
        builder: (context, viewModel) {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (viewModel.todoList.where((element) {
                    return element.isAccomplished == true;
                  }).isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        accomplishedToDos,
                        style: textTheme.subtitle1.copyWith(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: viewModel.todoList.where((element) {
                          return element.isAccomplished == true;
                        }).map((todo) {
                          return TodoItem(
                            title: todo.title,
                            description: todo.description,
                            onPressed: (context) {
                              Future.delayed(
                                const Duration(milliseconds: 200),
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
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            accomplishedEmpty,
                            style: textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
