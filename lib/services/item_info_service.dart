import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/repository/i_app_repository.dart';

import '../repository/item_category_repository.dart';
import '../utils/file_util.dart';
import 'i_services/i_item_info_service.dart';

class ItemInfoService implements IItemInfoService {
  final IAppRepository _appRepository;

  ItemInfoService(this._appRepository);

  @override
  Future getAll() async {
    await _appRepository.queryAll();
  }

  @override
  Future<List<ItemCategoryModel>> getAllItemCategory() async {
    List<ItemCategoryModel> result;
    if (ItemCategoryRepository.instance.itemCategories.isEmpty) {
      result = await FileUtil.loadCategoriesJson();
      var itemCategoriesMap = result.map((ic) => ic.toMap()).toList();
      await _appRepository.insertBatch('item_category', itemCategoriesMap);
    } else {
      result = ItemCategoryRepository.instance.itemCategories;
    }
    return result;
  }
}
