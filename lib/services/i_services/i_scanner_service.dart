import '../../models/item_category_model.dart';

abstract class IScannerService {
  Future<List<ItemCategoryModel>> getAllItemCategory();
}
