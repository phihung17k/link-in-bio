import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../bloc/item_info/item_info_state.dart';
import '../../../models/item_category_model.dart';
import 'widgets/item_detail_card.dart';

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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  ItemDetailCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Label",
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: nameTextController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: category.name),
                          onChanged: (value) {
                            bloc!.add(SetItemNameEvent(
                                name: nameTextController!.text));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ItemDetailCard(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("URL",
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: urlTextController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: getLabel(category.name!)),
                            onChanged: (value) {
                              bloc!.add(SetItemURLEvent(
                                  url: urlTextController!.text));
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                                "${category.webUrl}${context.watch<ItemInfoBloc>().state.item?.url ?? ""}",
                                style: const TextStyle(color: Colors.grey)),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                      Text("Or", style: Theme.of(context).textTheme.titleLarge),
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            bloc!
                                .addNavigatedEvent(NavigatorScannerPageEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text("Scan QR",
                              style: TextStyle(
                                  inherit: false, color: Colors.black))))
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: this.toString(),
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
