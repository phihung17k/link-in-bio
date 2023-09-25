import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/services/i_services/i_scanner_service.dart';

import '../repository/database_helper.dart';
import '../repository/i_app_repository.dart';
import '../utils/file_util.dart';

class ScannerService implements IScannerService {
  final IAppRepository _appRepository;

  ScannerService(this._appRepository);
  @override
  Future<List<ItemCategoryModel>> getAllItemCategory() async {
    try {
      // get from db
      var categories = await _queryCategoriesInDB();
      if (categories.isNotEmpty) {
        return categories.map((ic) => ItemCategoryModel.fromMap(ic)).toList();
      } else {
        // get from asset when db empty
        var rawCategories = await FileUtil.loadCategoriesJson();
        var rawCategoriesMap = rawCategories.map((ic) => ic.toMap()).toList();
        bool isInserted = await _appRepository.insertBatch(
            DatabaseHelper.itemCategory, rawCategoriesMap);

        if (isInserted) {
          var categories = await _queryCategoriesInDB();
          return categories.map((ic) => ItemCategoryModel.fromMap(ic)).toList();
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  Future<List<Map<String, Object?>>> _queryCategoriesInDB() async {
    return await _appRepository.queryAll(DatabaseHelper.itemCategory);
  }
}
