import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
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
                      labelText: "Phone Number"),
                  onChanged: (value) {
                    // context
                    //     .read<ItemInfoBloc>()
                    //     .add(SetItemURLEvent(url: phoneNumerController!.text));
                  },
                  onSubmitted: (value) {
                    // print("Submit $value");
                  },
                ),
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
                      labelText: "Message"),
                  onChanged: (value) {
                    // context
                    //     .read<ItemInfoBloc>()
                    //     .add(SetItemURLEvent(url: urlTextController!.text));
                  },
                )
              ])),
    );
  }
}
