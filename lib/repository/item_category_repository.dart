import '../models/item_category_model.dart';
import '../utils/file_util.dart';

class ItemCategoryRepository {
  ItemCategoryRepository._internal();
  static final ItemCategoryRepository instance =
      ItemCategoryRepository._internal();

  List<ItemCategoryModel> _itemCategories = [];

  Future<List<ItemCategoryModel>> getItemCategories() async {
    if (_itemCategories.isEmpty) {
      _itemCategories = await FileUtil.loadCategoriesJson();
    }
    return _itemCategories;
  }
}
