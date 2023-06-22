import '../models/models.dart';
import '../repository/item_category_repository.dart';

class LinkUtil {
  static Uri? getUri(ItemModel? item) {
    Uri? result = Uri.tryParse(getUriString(item));
    return result;
  }

  static String getUriString(ItemModel? item) {
    String result = "";
    switch (item?.category?.name?.toLowerCase()) {
      case "sms":
        SmsModel sms = item!.sms!;
        result = "sms:${sms.phoneNumber}?body=${sms.message}";
        break;
      case "facebook":
      case "twitter":
      case "youtube":
      case "tiktok":
      case "twitch":
        UrlModel url = item!.url!;
        result = "${item.category!.webUrl}${url.url}";
        break;
      case "phone":
        PhoneModel phone = item!.phone!;
        result = "tel:${phone.phoneNumber}";
        break;
      case "email":
        EmailModel email = item!.email!;
        result =
            "mailto:${email.address}?cc=${email.cc}&bcc=${email.bcc}&subject=${email.subject}&body=${email.body}";
        break;
      case "wifi":
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
      case "link":
        UrlModel url = item!.url!;
        // https://www.regex101.com/
        String urlPattern =
            r"^([a-zA-Z]*(\:\/\/))*([a-zA-Z]*\.)?([a-zA-Z]*[a-zA-Z0-9]*\.)+([a-zA-Z]+\/?)*";
        if (url.url!.startsWith(RegExp(urlPattern))) {
          String subUrlPattern =
              r"^([a-zA-Z]*\.)?([a-zA-Z]*[a-zA-Z0-9]*\.)+([a-zA-Z]+\/?)*";
          if (url.url!.startsWith(subUrlPattern)) {
            result = "http://${url.url}";
          } else {
            result = url.url!;
          }
        }
        break;
    }
    return result;
  }

  static ItemModel? convertQrCode(String rawValue) {
    ItemModel? result;
    RegExp regex = RegExp("^[^:]*");
    if (regex.hasMatch(rawValue)) {
      rawValue = rawValue.toLowerCase();
      // String schema = regex.stringMatch(rawValue)!.toLowerCase();
      result = _parseFromUri(rawValue);

      if (result == null) {}
    }
    return result;
  }

  static ItemModel? _parseFromUri(String rawValue) {
    ItemModel? result;
    Uri? uri = Uri.tryParse(rawValue);
    if (uri != null) {
      switch (uri.scheme) {
        case "http":
        case "https":
          // regex: \/\/[\w\d. -]+\/?
          String host = uri.host;
          if (host.isNotEmpty) {
            //standardized data
            List supportedHosts = [
              "facebook",
              "twitter",
              "youtube",
              "tiktok",
              "twitch"
            ];
            host = host.replaceAll(RegExp(r"(www\.)|(\.com)"), "");
            if (supportedHosts.contains(host)) {
              ItemCategoryRepository categoryRepo =
                  ItemCategoryRepository.instance;
              ItemCategoryModel category =
                  categoryRepo.itemCategories.firstWhere((c) => c.name == host);
              //remove origin, ex: https://facebook.com
              rawValue = rawValue.replaceFirst(uri.origin, "");
              result =
                  ItemModel(url: UrlModel(url: "${category.webUrl}$rawValue"));
            }
          }
          break;
        case "sms":
          // sms:12345?body=abc
          // String? message = uri.queryParameters['body'] ?? "";
          String? message;
          if (uri.queryParameters.containsKey('body')) {
            message = uri.queryParameters['body'];
          }
          result =
              ItemModel(sms: SmsModel(phoneNumber: uri.path, message: message));
          break;
        case "tel":
          // tel:1234,123
          result = ItemModel(phone: PhoneModel(phoneNumber: uri.path));
          break;
        case "mailto":
          // mailto:address?cc=cc&bcc=bcc&subject=subject&body=body
          result = ItemModel(phone: PhoneModel(phoneNumber: uri.path));
          break;
        case "wifi":
          // WIFI:T:<authentication-type>;S:<network-ssid>;P:<network-password>;H:<hidden-network>;;
          Map<String, String> map = {};
          List<String> paths = uri.path.split(';');
          for (String element in paths) {
            List<String> parts = element.split(":");
            map[parts.first] = parts.last;
          }
          result = ItemModel(
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
}
