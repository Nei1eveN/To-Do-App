import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/state/app_state/app_state.dart';

class ChangeTitleAction extends ReduxAction<AppState> {
  final String title;

  ChangeTitleAction({@required this.title});

  @override
  Future<AppState> reduce() async => state.copyWith(title: this.title);
}

class ChangePageIndexAction extends ReduxAction<AppState> {
  final int pageIndex;

  ChangePageIndexAction({@required this.pageIndex});

  @override
  Future<AppState> reduce() async => state.copyWith(pageIndex: pageIndex);
}
