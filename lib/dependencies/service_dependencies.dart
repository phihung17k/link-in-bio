import 'package:get_it/get_it.dart';
import 'package:link_in_bio/services/home_service.dart';
import 'package:link_in_bio/services/i_services/i_home_service.dart';
import 'package:link_in_bio/services/i_services/i_item_info_service.dart';
import 'package:link_in_bio/services/i_services/i_splash_service.dart';
import 'package:link_in_bio/services/item_info_service.dart';
import 'package:link_in_bio/services/splash_service.dart';

class ServiceDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<ISplashService>(() => SplashService(injector()));
    injector.registerFactory<IHomeService>(() => HomeService(injector()));
    injector
        .registerFactory<IItemInfoService>(() => ItemInfoService(injector()));
  }
}
