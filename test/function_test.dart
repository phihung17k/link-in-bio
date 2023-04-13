import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/utils/file_util.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Load category from json file', () async {
    List<ItemCategoryModel> categories = await FileUtil.loadAssetJson();

    expect(true, categories.isNotEmpty);
    // expect(true, categories.length);
  });
}
