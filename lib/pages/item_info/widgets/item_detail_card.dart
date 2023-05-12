import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../models/item_category_model.dart';

class ItemDetailCard extends StatelessWidget {
  final TextEditingController? textController;
  final ItemCategoryModel? category;
  final String label;
  final bool showDetailLink;

  const ItemDetailCard(
      {super.key,
      this.textController,
      this.label = "",
      this.category,
      this.showDetailLink = false});

  String getPlaceholder(String name) {
    switch (name.toLowerCase()) {
      case "facebook":
        return "Facebook ID";
      case "tiktok":
        return "Tiktok ID";
      case "twitter":
        return "Twitter ID";
      case "instagram":
        return "Instagram ID";
      case "youtube":
        return "Youtube Channel";
      case "shopee":
        return "Shopee ID";
      case "twitch":
        return "Twitch ID";
      case "phone":
        return "Phone Number";
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
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: getPlaceholder(category!.name!)),
                  keyboardType: category!.name!.toLowerCase() == "phone"
                      ? TextInputType.phone
                      : null,
                  onChanged: (value) {
                    // context
                    //     .read<ItemInfoBloc>()
                    //     .add(SetItemURLEvent(url: urlTextController!.text));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                if (showDetailLink)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                        "${category?.webUrl}${context.watch<ItemInfoBloc>().state.item?.url?.url ?? ""}",
                        style: const TextStyle(color: Colors.grey)),
                  )
              ])),
    );
  }
}
