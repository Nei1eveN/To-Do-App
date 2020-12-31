import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TodoGridView extends StatelessWidget {
  /// Staggered GridView for displaying different sizes of tiles
  const TodoGridView({@required this.children, @required this.staggeredTiles});

  final List<Widget> children;
  final List<StaggeredTile> staggeredTiles;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      staggeredTiles: staggeredTiles,
      children: children,
    );
  }
}
