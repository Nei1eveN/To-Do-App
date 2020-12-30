import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/constants.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  const factory AppState({String title, int pageIndex, List<Todo> todoList}) = _AppState;

  factory AppState.initState() => const AppState(title: active, todoList: [], pageIndex: 0);
}
