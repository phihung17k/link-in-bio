import 'dart:async';

import 'package:link_in_bio/utils/enums.dart';

import '../models/models.dart';
import '../repository/item_category_repository.dart';

class LinkUtil {
  // parse the inputted item info into Uri for creating QR code
  static Uri? getUri(ItemModel? item) {
    Uri? result = Uri.tryParse(getUriString(item));
    return result;
  }

  static String getUriString(ItemModel? item) {
    String? name = item?.category?.name;
    if (name == null || name.isEmpty) {
      return "";
    }
    String result = "";
    ConstantEnum categoryName = ConstantEnum.values.firstWhere(
        (element) => element.name == name.toLowerCase(),
        orElse: () => ConstantEnum.unknow);
    switch (categoryName) {
      case ConstantEnum.sms:
        SmsModel sms = item!.sms!;
        result =
            "${ConstantEnum.sms.name}:${sms.phoneNumber}?body=${sms.message}";
        break;
      case ConstantEnum.facebook:
      case ConstantEnum.twitter:
      case ConstantEnum.youtube:
      case ConstantEnum.tiktok:
      case ConstantEnum.twitch:
        UrlModel url = item!.url!;
        result = "${item.category!.webUrl}${url.url}";
        break;
      case ConstantEnum.phone:
        PhoneModel phone = item!.phone!;
        result = "${ConstantEnum.tel.name}:${phone.phoneNumber}";
        break;
      case ConstantEnum.email:
        EmailModel email = item!.email!;
        result =
            "${ConstantEnum.mailto.name}:${email.address}?cc=${email.cc}&bcc=${email.bcc}&subject=${email.subject}&body=${email.body}";
        break;
      case ConstantEnum.wifi:
        WifiModel wifi = item!.wifi!;
        String encryption = "nopass";
        if (wifi.encryption == "WPA/WPA2") {
          encryption = "WPA2";
        } else if (wifi.encryption == "WEP") {
          encryption = wifi.encryption!;
        }
        result =
            "WIFI:T:$encryption;S:${wifi.networkName};P:${wifi.password};H:true;;";
        break;
      case ConstantEnum.link:
        UrlModel url = item!.url!;
        // www.regex101.com/
        // regex101.com/
        String urlPattern =
            r"^[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b(?:[-a-zA-Z0-9()@:%_\+.~#?&//=]*)$";
        if (url.url!.startsWith(RegExp(urlPattern))) {
          result = "${ConstantEnum.http.name}://${url.url}";
        } else {
          result = url.url!;
        }
        break;
      default:
        break;
    }
    return result;
  }

  // convert QR code into the item info
  static Future<ItemModel?> convertQrCode(String? rawValue) async {
    ItemModel? result;
    if (rawValue!.trim().isEmpty) {
      return null;
    }
    result = await _parseFromUri(rawValue);
    return result;
  }

  static Future<ItemModel?> _parseFromUri(String rawValue) async {
    ItemModel? result;
    Uri? uri = Uri.tryParse(rawValue);
    if (uri != null) {
      ConstantEnum schema = ConstantEnum.values.firstWhere(
          (element) => element.name.toLowerCase() == uri.scheme.toLowerCase(),
          orElse: () => ConstantEnum.unknow);
      var itemCategories =
          await ItemCategoryRepository.instance.getItemCategories();
      switch (schema) {
        case ConstantEnum.http:
        case ConstantEnum.https:
          // regex: \/\/[\w\d. -]+\/?
          String host = uri.host;
          if (host.isNotEmpty) {
            //standardized data
            List<String> supportedHosts = [
              ConstantEnum.facebook.name,
              ConstantEnum.twitter.name,
              ConstantEnum.youtube.name,
              ConstantEnum.tiktok.name,
              ConstantEnum.twitch.name,
            ];
            host = host.replaceAll(RegExp(r"(www\.)|(\.com)|(\.tv)"), "");
            if (supportedHosts.contains(host)) {
              ItemCategoryModel? category = itemCategories
                  .firstWhere((c) => c.name?.toLowerCase() == host);
              //remove origin, ex: https://facebook.com
              rawValue = rawValue.replaceFirst(uri.origin, "");
              if (rawValue.startsWith("/")) {
                rawValue = rawValue.substring(1);
              }
              ConstantEnum constantEnum = ConstantEnum.values
                  .firstWhere((element) => element.name == host);
              result = _setUpItem(itemCategories, constantEnum,
                  url: UrlModel(url: rawValue));
            } else {
              result = _setUpItem(itemCategories, ConstantEnum.link,
                  url: UrlModel(url: rawValue));
            }
          }
          break;
        case ConstantEnum.sms:
          // sms:12345?body=abc
          // String? message = uri.queryParameters['body'] ?? "";
          String? message;
          if (uri.queryParameters.containsKey('body')) {
            message = uri.queryParameters['body'];
          }
          result = _setUpItem(itemCategories, ConstantEnum.sms,
              sms: SmsModel(phoneNumber: uri.path, message: message));
          break;
        case ConstantEnum.tel:
          // tel:1234,123
          result = _setUpItem(itemCategories, ConstantEnum.phone,
              phone: PhoneModel(phoneNumber: uri.path));
          break;
        case ConstantEnum.mailto:
          // mailto:address?cc=cc&bcc=bcc&subject=subject&body=body
          result = _setUpItem(itemCategories, ConstantEnum.email,
              email: EmailModel(
                  address: uri.path,
                  cc: uri.queryParameters['cc'],
                  bcc: uri.queryParameters['bcc'],
                  subject: uri.queryParameters['subject'],
                  body: uri.queryParameters['body']));
          break;
        case ConstantEnum.wifi:
          // WIFI:T:<authentication-type>;S:<network-ssid>;P:<network-password>;H:<hidden-network>;;
          Map<String, String> map = {};
          List<String> paths = uri.path.split(';');
          for (String element in paths) {
            List<String> parts = element.split(":");
            map[parts.first.toUpperCase()] = parts.last;
          }
          result = _setUpItem(itemCategories, ConstantEnum.wifi,
              wifi: WifiModel(
                  networkName: map['S'],
                  encryption: map['T'],
                  password: map['P'],
                  isHidden: map['H'] == 'true'));
          break;
        default:
          //try http https again
          break;
      }
    }
    return result;
  }

  static ItemModel _setUpItem(
      List<ItemCategoryModel> itemCategories, ConstantEnum constantEnum,
      {UrlModel? url,
      SmsModel? sms,
      PhoneModel? phone,
      EmailModel? email,
      WifiModel? wifi}) {
    return ItemModel(
        name: constantEnum.name,
        url: url,
        sms: sms,
        phone: phone,
        email: email,
        wifi: wifi,
        category: itemCategories
            .firstWhere((c) => c.name?.toLowerCase() == constantEnum.name));
  }
}
