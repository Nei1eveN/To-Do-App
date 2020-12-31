import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/state/app_state/actions/todo_actions.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:uuid/uuid.dart';

class AddTodoArguments {
  final Todo todo;

  const AddTodoArguments({@required this.todo});
}

/// TODO: add checker for [Todo] isAccomplished field
class AddTodo extends StatefulWidget {
  static const route = 'add_todo';

  final AddTodoArguments args;

  const AddTodo({Key key, @required this.args}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  bool isChecked;

  @override
  void initState() {
    isChecked = false;
    if (widget.args.todo != null) {
      final todo = widget.args.todo;
      setChecked(value: todo.isAccomplished);
      _titleController.text = todo.title;
      _descriptionController.text = todo.description;
    }
    super.initState();
  }

  void setChecked({bool value}) => setState(() => isChecked = value);

  @override
  Widget build(BuildContext context) {
    final todo = widget.args.todo;
    final textTheme = Theme.of(context).textTheme;
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (BuildContext context, vm) {
        return WillPopScope(
          onWillPop: () async {
            FocusScope.of(context).unfocus();
            return Navigator.canPop(context);
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: isChecked ? Colors.red : Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  final title = _titleController.text;
                  final description = _descriptionController.text;
                  if (widget.args.todo == null && (title.isNotEmpty || description.isNotEmpty)) {
                    StoreProvider.dispatch<AppState>(
                      context,
                      AddTodoAction(
                        todo: Todo(
                          id: Uuid().v1(),
                          title: title,
                          description: description,
                          isAccomplished: isChecked
                        ),
                      ),
                    );
                  } else if (todo != null) {
                    StoreProvider.dispatch<AppState>(
                      context,
                      UpdateTodoAction(
                        todo: Todo(
                          id: todo.id,
                          title: title,
                          description: description,
                          isAccomplished: isChecked,
                        ),
                      ),
                    );
                  }
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () => Navigator.of(context).pop(),
                  );
                },
              ),
              actions: [
                Theme(
                  data: Theme.of(context).copyWith(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) => setChecked(value: value),
                    activeColor: Colors.red,
                  ),
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w800, fontSize: 18.0),
                    decoration: InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      hintStyle: textTheme.subtitle1.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w800,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      autofocus: _descriptionController.text.isEmpty,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        border: InputBorder.none,
                        hintStyle: textTheme.subtitle2.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      maxLines: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
