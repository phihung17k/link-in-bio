import '../../models/item_category_model.dart';

abstract class IItemInfoService {
  Future getAll();
  Future<List<ItemCategoryModel>> getAllItemCategory();
}
