import '../../models/item_category_model.dart';

abstract class IItemInfoService {
  Future<List<ItemCategoryModel>> getAllItemCategory();
  Future<bool> addItem(Map<String, Object?> values);
}
