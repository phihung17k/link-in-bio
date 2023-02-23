import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/pages/qrcode_sharing_page.dart';
import 'package:link_in_bio/routes.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../app_icons.dart';
import '../../utils/pop_with_results.dart';

class ItemContentSubPage extends StatefulWidget {
  final String? initialName;
  final String? initialURL;
  const ItemContentSubPage({super.key, this.initialName, this.initialURL});

  @override
  State<ItemContentSubPage> createState() => _ItemContentSubPageState();
}

class _ItemContentSubPageState extends State<ItemContentSubPage> {
  TextEditingController? nameTextController;
  TextEditingController? urlTextController;

  ItemInfoBloc? bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ItemInfoBloc>();
    String? initialName = bloc?.state.item?.name;
    String? initialURL = bloc?.state.item?.url;
    nameTextController = TextEditingController(text: initialName);
    urlTextController = TextEditingController(text: initialURL);
  }

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
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<ItemInfoBloc, ItemInfoState>(
          bloc: bloc,
          buildWhen: (previous, current) {
            return previous.selectedCategoryIndex !=
                current.selectedCategoryIndex;
          },
          builder: (context, state) {
            ItemCategoryModel category =
                state.itemCategories![state.selectedCategoryIndex!];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Label"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: nameTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: category.name),
                    onChanged: (value) {
                      bloc!.add(
                          SetItemNameEvent(name: nameTextController!.text));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("URL"),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: urlTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelText: getLabel(category.name!)),
                    onChanged: (value) {
                      bloc!.add(SetItemURLEvent(url: urlTextController!.text));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${category.baseURL}${context.watch<ItemInfoBloc>().state.item?.url ?? ""}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc!.addNavigatedEvent(BackingHomePageEvent());
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

  @override
  void dispose() {
    urlTextController?.dispose();
    nameTextController?.dispose();
    super.dispose();
  }
}
