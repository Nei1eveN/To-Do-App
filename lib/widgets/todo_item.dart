import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final Function onPressed;

  const TodoItem({Key key, this.title, this.description, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title.isNotEmpty) ...[
                Text(
                  title,
                  style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
              if (description.isNotEmpty) ...[
                Text(
                  description,
                  style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400, fontSize: 12.0),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
