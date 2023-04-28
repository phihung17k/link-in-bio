import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../models/item_category_model.dart';

class SmsCard extends StatelessWidget {
  final TextEditingController? urlTextController;
  final ItemCategoryModel? category;

  const SmsCard({super.key, this.urlTextController, this.category});

  String getLabel(String name) {
    switch (name.toLowerCase()) {
      case "facebook":
        return "Facebook ID";
      case "tiktok":
        return "Tiktok ID";
      case "zalo":
        return "Zalo ID";
      case "twitter":
        return "Twitter ID";
      case "instagram":
        return "Instagram ID";
      case "youtube":
        return "Youtube Channel";
      case "amazon":
        return "Amazon ID";
      case "shopee":
        return "Shopee ID";
      case "lazada":
        return "Lazada ID";
      default:
        return "Link";
    }
  }

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
                  controller: urlTextController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Phone Number"),
                  onChanged: (value) {
                    context
                        .read<ItemInfoBloc>()
                        .add(SetItemURLEvent(url: urlTextController!.text));
                  },
                  onSubmitted: (value) {
                    print("Submit $value");
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                // TextField(
                //   controller: urlTextController,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       labelText: "Phone Number"),
                //   onChanged: (value) {
                //     context
                //         .read<ItemInfoBloc>()
                //         .add(SetItemURLEvent(url: urlTextController!.text));
                //   },
                // )
              ])),
    );
  }
}
