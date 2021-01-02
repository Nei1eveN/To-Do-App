import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../models/todo.dart';
import '../../state/app_state/app_state.dart';
import '../../utils/constants.dart';
import '../home_page/home_page.dart';

class AddTodoArguments {
  final Todo todo;

  const AddTodoArguments({@required this.todo});
}

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

  void _dispatchAction(BuildContext context) {
    FocusScope.of(context).unfocus();
    final todo = widget.args.todo;
    final title = _titleController.text;
    final description = _descriptionController.text;
    Navigator.of(context)
        .pop(HomePageArguments(todo, title: title, description: description, isAccomplished: isChecked));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return StoreConnector<AppState, MainViewModel>(
      model: MainViewModel(),
      builder: (BuildContext context, vm) {
        return WillPopScope(
          onWillPop: () async {
            _dispatchAction(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: isChecked ? Colors.red : Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => _dispatchAction(context),
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
                      hintText: title,
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
                        hintText: note,
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
