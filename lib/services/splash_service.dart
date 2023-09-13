import 'package:link_in_bio/models/data_model.dart';
import 'package:link_in_bio/models/item_category_model.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/services/i_services/i_splash_service.dart';
import '../repository/database_helper.dart';
import '../repository/i_app_repository.dart';
import 'package:link_in_bio/utils/general_util.dart';

class SplashService with GeneralUtil implements ISplashService {
  final IAppRepository _appRepository;

  SplashService(this._appRepository);

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

            item = handleCategorCase(category.name!, params: [item, itemMap])
                as ItemModel;
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
  Object? onSms({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(
      sms: SmsModel(
          phoneNumber: itemMap['phone_number'], message: itemMap['message']),
    );
  }

  @override
  Object? onUrl({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(url: UrlModel(url: itemMap['url']));
  }

  @override
  Object? onPhone({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(
        phone: PhoneModel(phoneNumber: itemMap['phone_number']));
  }

  @override
  Object? onEmail({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(
      email: EmailModel(
        address: itemMap['address'],
        cc: itemMap['cc'],
        bcc: itemMap['bcc'],
        subject: itemMap['subject'],
        body: itemMap['body'],
      ),
    );
  }

  @override
  Object? onWifi({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(
      wifi: WifiModel(
        networkName: itemMap['network_name'],
        password: itemMap['password'],
        encryption: itemMap['encryption'],
        isHidden: itemMap['is_hidden'] == 1,
      ),
    );
  }

  @override
  Object? onLink({List<Object?>? params}) {
    var item = params![0] as ItemModel;
    var itemMap = params[1] as Map<String, dynamic>;
    return item.copyWith(url: UrlModel(url: itemMap['url']));
  }
}
