import 'package:flutter/material.dart';

class SelectableEntityList<T> extends StatelessWidget {
  const SelectableEntityList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding = const EdgeInsets.fromLTRB(16, 4, 16, 16),
    this.shrinkWrap = false,
    this.physics,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
    );
  }
}
