import 'package:flutter/material.dart';

class ItemAnimatedBuilder extends StatelessWidget {
  final Listenable animation;
  final Widget? child;
  const ItemAnimatedBuilder({super.key, required this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        // animation's effect for reorder item
        return Material(
            elevation: 5,
            color: Colors.transparent,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(30),
            child: child);
      },
      child: child,
    );
  }
}
