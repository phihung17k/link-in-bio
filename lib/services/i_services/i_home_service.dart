import '../../models/item_model.dart';

abstract class IHomeService {
  Future<List<ItemModel>> getAllItem();
  Future<bool> deleteItem(int id);
}
