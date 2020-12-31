import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  final String headerTitle;

  const HeaderItem({Key key, @required this.headerTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        headerTitle,
        style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey[700]),
      ),
    );
  }
}
