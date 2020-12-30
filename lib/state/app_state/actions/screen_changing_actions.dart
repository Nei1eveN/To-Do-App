import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/state/app_state/app_state.dart';

class ChangeScreenAction extends ReduxAction<AppState> {
  final String title;
  final int pageIndex;

  ChangeScreenAction({@required this.title, @required this.pageIndex});

  @override
  Future<AppState> reduce() async => state.copyWith(title: title, pageIndex: pageIndex);
}
