import '../models/item_category_model.dart';

class ItemCategoryRepository {
  ItemCategoryRepository._internal();
  static final ItemCategoryRepository instance =
      ItemCategoryRepository._internal();

  List<ItemCategoryModel> itemCategories = [];
}
