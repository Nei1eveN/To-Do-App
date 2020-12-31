import 'package:flutter/material.dart';

class EmptyListPlaceHolder extends StatelessWidget {
  final String placeHolderTitle;

  const EmptyListPlaceHolder({Key key, @required this.placeHolderTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text(
            placeHolderTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
