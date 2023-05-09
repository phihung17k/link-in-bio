import '../models/models.dart';

class LinkUtil {
  static Uri? getUri(ItemModel? item) {
    Uri? result;
    switch (item?.category?.name?.toLowerCase()) {
      case "sms":
        SmsModel sms = item!.sms!;
        result = Uri.tryParse("sms:${sms.phoneNumber}?body=${sms.message}");
        break;
      case "facebook":
      case "twitter":
      case "youtube":
      case "tiktok":
      case "twitch":
        UrlModel url = item!.url!;
        result = Uri.tryParse("${item.category!.webUrl}${url.url}");
        break;
      case "phone":
        PhoneModel phone = item!.phone!;
        result = Uri.tryParse("tel:${phone.phoneNumber}");
        break;
    }
    return result;
  }

  static String getLink(ItemModel? item) {
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
    }
    return result;
  }
}
