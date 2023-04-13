import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/item_category_model.dart';

class FileUtil {
  static Future<List<ItemCategoryModel>> loadAssetJson() async {
    return await rootBundle.loadStructuredData(
      'assets/text/item_category.json',
      (jsonString) {
        List<ItemCategoryModel> categories = [];
        Map<String, dynamic> data = jsonDecode(jsonString);
        ItemCategoryModel? category;
        for (var entry in data.entries) {
          List<String> keys = entry.key.split(".");
          if (keys.length == 3) {
            if (category == null) {
              category = ItemCategoryModel(
                  topic: keys[0],
                  name: keys[1],
                  imageURL: "assets/images/${entry.value as String}");
              continue;
            }
            category = category.copyWith(baseURL: entry.value as String);
            categories.add(category);
            category = null;
          }
        }
        return Future.value(categories);
      },
    );
  }
}
