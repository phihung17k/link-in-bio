import 'enums.dart';

class GeneralUtil {
  Object? handleCategorCase(String categoryName, {List<Object?>? params}) {
    Object? result;
    String nameLower = categoryName.toLowerCase();
    ConstantEnum constant = ConstantEnum.values.firstWhere(
        (element) => element.name == nameLower,
        orElse: () => ConstantEnum.unknow);
    switch (constant) {
      case ConstantEnum.http:
      case ConstantEnum.https:
        result = onHttps(params: params);
        break;
      case ConstantEnum.sms:
        result = onSms(params: params);
        break;
      case ConstantEnum.facebook:
      case ConstantEnum.twitter:
      case ConstantEnum.youtube:
      case ConstantEnum.tiktok:
      case ConstantEnum.twitch:
        result = onUrl(params: params);
        break;
      case ConstantEnum.phone:
        result = onPhone(params: params);
        break;
      case ConstantEnum.email:
        result = onEmail(params: params);
        break;
      case ConstantEnum.wifi:
        result = onWifi(params: params);
        break;
      case ConstantEnum.link:
        result = onLink(params: params);
        break;
      default:
        break;
    }
    return result;
  }

  Object? onHttps({List<Object?>? params}) {
    return null;
  }

  Object? onSms({List<Object?>? params}) {
    return null;
  }

  Object? onUrl({List<Object?>? params}) {
    return null;
  }

  Object? onPhone({List<Object?>? params}) {
    return null;
  }

  Object? onEmail({List<Object?>? params}) {
    return null;
  }

  Object? onWifi({List<Object?>? params}) {
    return null;
  }

  Object? onLink({List<Object?>? params}) {
    return null;
  }
}
