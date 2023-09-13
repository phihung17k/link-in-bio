import '../../models/item_model.dart';

abstract class ISplashService {
  Future<List<ItemModel>> getAllItem();
}
