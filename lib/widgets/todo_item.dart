import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String description;
  final Function(BuildContext) onPressed;

  const TodoItem({Key key, this.title, this.description, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final circularRadius = BorderRadius.circular(5.0);
    final titleNotEmpty = title.isNotEmpty;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: circularRadius),
      child: InkWell(
        onTap: () => onPressed(context),
        borderRadius: circularRadius,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (titleNotEmpty) ...[
                Text(
                  title,
                  style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
              if (description.isNotEmpty) ...[
                if (titleNotEmpty) const SizedBox(height: 8.0),
                Expanded(
                  child: Text(
                    description,
                    style: textTheme.subtitle2.copyWith(fontWeight: FontWeight.w400, fontSize: 12.0),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
