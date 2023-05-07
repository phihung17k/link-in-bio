import 'package:flutter/material.dart';
import '../../../models/item_category_model.dart';

class SmsCard extends StatelessWidget {
  final TextEditingController? phoneNumerController;
  final TextEditingController? messageController;
  final ItemCategoryModel? category;

  const SmsCard(
      {super.key,
      this.phoneNumerController,
      this.messageController,
      this.category});

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
                Text("SMS", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: phoneNumerController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Phone Number")),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Message"))
              ])),
    );
  }
}
