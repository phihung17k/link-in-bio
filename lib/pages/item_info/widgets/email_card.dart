import 'package:flutter/material.dart';
import '../../../models/item_category_model.dart';

class EmailCard extends StatelessWidget {
  final TextEditingController? addressController;
  final TextEditingController? ccController;
  final TextEditingController? bccController;
  final TextEditingController? subjectController;
  final TextEditingController? bodyController;
  final ItemCategoryModel? category;

  const EmailCard(
      {super.key,
      this.addressController,
      this.ccController,
      this.bccController,
      this.subjectController,
      this.bodyController,
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
                    controller: addressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "To"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: ccController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Cc"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: bccController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Bcc"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: subjectController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Subject")),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: bodyController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Body"))
              ])),
    );
  }
}
