import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/state/app_state/actions/screen_changing_actions.dart';
import 'package:todo_app/state/app_state/actions/todo_actions.dart';
import 'package:todo_app/state/app_state/app_state.dart';

void main() {
  StoreTester<AppState> storeTester;

  setUp(() {
    storeTester = StoreTester<AppState>(initialState: AppState.initState());
  });

  test(
    'should dispatch ChangeScreenAction',
    () async {
      // check initial values
      expect(storeTester.state.title, 'Active');
      expect(storeTester.state.pageIndex, 0);

      // dispatch 1st action
      storeTester.dispatch(ChangeScreenAction(title: 'Accomplished', pageIndex: 1));

      // await result
      TestInfo<AppState> info = await storeTester.wait(ChangeScreenAction);
      // expect new values
      expect(info.state.title, 'Accomplished');
      expect(info.state.pageIndex, 1);

      // dispatch 2nd action
      storeTester.dispatch(ChangeScreenAction(title: 'Active', pageIndex: 0));
      // await new result
      info = await storeTester.wait(ChangeScreenAction);
      // expect new values from new result
      expect(info.state.title, 'Active');
      expect(info.state.pageIndex, 0);
    },
  );

  test(
    'should Dispatch AddTodoAction',
    () async {
      expect(storeTester.state.todoList, isEmpty);

      final newTodo = Todo(id: 'randomId', title: 'random title', description: 'random desc', isAccomplished: false);
      storeTester.dispatch(AddTodoAction(todo: newTodo));

      TestInfo<AppState> info = await storeTester.wait(AddTodoAction);

      expect(info.state.todoList, <Todo>[newTodo]);

      final anotherTodo =
          Todo(id: 'randomId2', title: 'random title2', description: 'random desc2', isAccomplished: true);
      storeTester.dispatch(AddTodoAction(todo: anotherTodo));

      info = await storeTester.wait(AddTodoAction);

      expect(info.state.todoList, <Todo>[newTodo, anotherTodo]);
    },
  );
}
