import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import '../app_state.dart';

class AddTodoAction extends ReduxAction<AppState> {
  final Todo todo;

  AddTodoAction({@required this.todo});

  @override
  Future<AppState> reduce() async {
    return state.copyWith(
      todoList: <Todo>[
        ...?state.todoList,
        Todo(
          id: todo.id,
          title: todo.title,
          description: todo.description,
          isAccomplished: todo.isAccomplished,
        )
      ].toUnmodifiable(),
    );
  }
}

class UpdateTodoAction extends ReduxAction<AppState> {
  final Todo todo;

  UpdateTodoAction({@required this.todo});

  @override
  Future<AppState> reduce() async {
    return state.copyWith(todoList: state.todoList.map((element) => element.id == todo.id ? todo : element).toUnmodifiable());
  }
}
