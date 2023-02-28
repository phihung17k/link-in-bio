import 'package:flutter/material.dart';

class ItemDetailCard extends StatelessWidget {
  final Widget? child;

  const ItemDetailCard({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(padding: const EdgeInsets.all(15), child: child),
    );
  }
}
