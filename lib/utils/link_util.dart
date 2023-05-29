import '../models/models.dart';

class LinkUtil {
  static Uri? getUri(ItemModel? item) {
    Uri? result = Uri.tryParse(getUriString(item));
    // switch (item?.category?.name?.toLowerCase()) {
    //   case "sms":
    //     SmsModel sms = item!.sms!;
    //     result = Uri.tryParse("sms:${sms.phoneNumber}?body=${sms.message}");
    //     break;
    //   case "facebook":
    //   case "twitter":
    //   case "youtube":
    //   case "tiktok":
    //   case "twitch":
    //     UrlModel url = item!.url!;
    //     result = Uri.tryParse("${item.category!.webUrl}${url.url}");
    //     break;
    //   case "phone":
    //     PhoneModel phone = item!.phone!;
    //     result = Uri.tryParse("tel:${phone.phoneNumber}");
    //     break;
    // }
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
    }
    return result;
  }
}
