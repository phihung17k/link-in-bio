import '../../models/item_category_model.dart';
import '../../models/item_model.dart';

abstract class IItemInfoService {
  Future<List<ItemModel>> getAllItem();
  Future<List<ItemCategoryModel>> getAllItemCategory();
  Future<bool> addItem(Map<String, Object?> values);
}
