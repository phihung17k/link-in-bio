import 'package:flutter/material.dart';
import 'package:link_in_bio/routes.dart';

import '../models/item_model.dart';
import '../utils/pop_with_results.dart';

class ItemCategoryChoosingPage extends StatefulWidget {
  const ItemCategoryChoosingPage({super.key});

  @override
  State<ItemCategoryChoosingPage> createState() =>
      _ItemCategoryChoosingPageState();
}

class _ItemCategoryChoosingPageState extends State<ItemCategoryChoosingPage> {
  // name, path image
  Map<String, String> maps = {
    'Facebook': 'assets/images/default_avatar.png',
    'Tiktok': 'assets/images/default_avatar.png',
    'Zalo': 'assets/images/default_avatar.png',
    'Twitter': 'assets/images/default_avatar.png',
    'Instagram': 'assets/images/default_avatar.png',
    'Youtube': 'assets/images/default_avatar.png',
    'Amazon': 'assets/images/default_avatar.png',
    'Shopee': 'assets/images/default_avatar.png',
    'Lazada': 'assets/images/default_avatar.png',
    'Tiki': 'assets/images/default_avatar.png',
    'Link': 'assets/images/default_avatar.png',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose item category"),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 8 / 7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: maps.length,
            itemBuilder: (context, index) {
              MapEntry<String, String> pair = maps.entries.elementAt(index);
              ItemModel item =
                  ItemModel(name: pair.key, symbolPath: pair.value);
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.itemInfo, arguments: item)
                      .then((results) {
                    if (results is PopWithResults<ItemModel>) {
                      Navigator.of(context).pop(results);
                    }
                  });
                },
                highlightColor: Colors.blue,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            pair.value,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitHeight,
                          ),
                          Text(pair.key)
                        ]),
                  ),
                ),
              );
            },
          )),
    );
  }
}
