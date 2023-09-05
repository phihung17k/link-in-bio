import 'package:link_in_bio/models/data_model.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/services/i_services/i_home_service.dart';

import '../repository/database_helper.dart';
import '../repository/i_app_repository.dart';
import '../utils/enums.dart';

class HomeService implements IHomeService {
  final IAppRepository _appRepository;

  HomeService(this._appRepository);

  @override
  Future<List<ItemModel>> getAllItem() async {
    try {
      var rawItems = await _appRepository.queryAll(DatabaseHelper.item);
      if (rawItems.isNotEmpty) {
        List<ItemModel> result = [];

        for (Map<String, dynamic> itemMap in rawItems) {
          int categoryId = itemMap['item_category_id'];
          var categoryMap = await _appRepository.queryFromId(
              DatabaseHelper.itemCategory, categoryId);
          if (categoryMap.isNotEmpty) {
            var category = ItemCategoryModel.fromMap(categoryMap);
            var item = ItemModel.fromMap(itemMap);
            item = item.copyWith(category: category);
            ConstantEnum categoryName = ConstantEnum.values.firstWhere(
                (ce) => ce.name == category.name?.toLowerCase(),
                orElse: () => ConstantEnum.unknow);
            switch (categoryName) {
              case ConstantEnum.sms:
                item = item.copyWith(
                  sms: SmsModel(
                      phoneNumber: itemMap['phone_number'],
                      message: itemMap['message']),
                );
                break;
              case ConstantEnum.facebook:
              case ConstantEnum.twitter:
              case ConstantEnum.youtube:
              case ConstantEnum.tiktok:
              case ConstantEnum.twitch:
                item = item.copyWith(url: UrlModel(url: itemMap['url']));
                break;
              case ConstantEnum.phone:
                item = item.copyWith(
                    phone: PhoneModel(phoneNumber: itemMap['phone_number']));
                break;
              case ConstantEnum.email:
                item = item.copyWith(
                  email: EmailModel(
                    address: itemMap['address'],
                    cc: itemMap['cc'],
                    bcc: itemMap['bcc'],
                    subject: itemMap['subject'],
                    body: itemMap['body'],
                  ),
                );
                break;
              case ConstantEnum.wifi:
                item = item.copyWith(
                  wifi: WifiModel(
                    networkName: itemMap['network_name'],
                    password: itemMap['password'],
                    encryption: itemMap['encryption'],
                    isHidden: itemMap['is_hidden'],
                  ),
                );
                break;
              case ConstantEnum.link:
                item = item.copyWith(url: UrlModel(url: itemMap['url']));
                break;
              default:
                break;
            }

            result.add(item);
          }
        }
        return result;
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  @override
  Future<bool> deleteItem(int id) async {
    try {
      return await _appRepository.delete(DatabaseHelper.item, id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
