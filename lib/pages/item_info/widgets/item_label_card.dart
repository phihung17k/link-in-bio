import 'package:flutter/material.dart';

class ItemLabelCard extends StatelessWidget {
  final TextEditingController? nameTextController;
  final String? label;

  const ItemLabelCard({super.key, this.nameTextController, this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: nameTextController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: label),
              ),
            ],
          )),
    );
  }
}
