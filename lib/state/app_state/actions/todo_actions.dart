import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/state/app_state/app_state.dart';

class AddTodoAction extends ReduxAction<AppState> {
  final Todo todo;

  AddTodoAction({@required this.todo});

  @override
  Future<AppState> reduce() async {
    return state.copyWith(
      todoList: <Todo>[]
        ..addAll(state.todoList)
        ..add(Todo(id: todo.id, title: todo.title, description: todo.description, isAccomplished: todo.isAccomplished)),
    );
  }
}

class UpdateTodoAction extends ReduxAction<AppState> {
  final Todo todo;

  UpdateTodoAction({@required this.todo});

  @override
  Future<AppState> reduce() async {
    final newList = <Todo>[]..addAll(state.todoList);
    final index = newList.indexWhere((element) => element.id == this.todo.id);
    newList.replaceRange(index, index + 1, [todo]);
    return state.copyWith(todoList: newList);
  }
}
