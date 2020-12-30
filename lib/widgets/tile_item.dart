import 'package:flutter/material.dart';

class TileItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function(BuildContext context) onTap;
  final Color focusColor;
  final bool isSelected;

  const TileItem({
    Key key,
    @required this.iconData,
    @required this.title,
    @required this.onTap,
    @required this.focusColor,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const circularRadius = Radius.circular(32.0);
    final iconColor = isSelected ? Colors.white : null;
    const sideBorderRadius = BorderRadius.only(bottomRight: circularRadius, topRight: circularRadius);
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: ClipRRect(
        borderRadius: isSelected ? sideBorderRadius : BorderRadius.zero,
        child: ListTile(
          shape: const RoundedRectangleBorder(borderRadius: sideBorderRadius),
          leading: Icon(
            iconData,
            color: iconColor,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: iconColor,
                  fontSize: 15.0,
                ),
          ),
          tileColor: isSelected ? focusColor : null,
          onTap: () => onTap(context),
        ),
      ),
    );
  }
}
