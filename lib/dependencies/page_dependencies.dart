import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:link_in_bio/pages/pages.dart';
import 'package:link_in_bio/pages/qrcode_sharing_page.dart';
import 'package:link_in_bio/routes.dart';

import '../pages/item_info/item_info_page.dart';

class PageDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<Widget>(() => HomePage(injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => const ItemInfoPage(),
        instanceName: Routes.itemInfo);
    injector.registerFactory<Widget>(() => const ItemCategoryChoosingPage(),
        instanceName: Routes.itemCategoryChoosing);
    injector.registerFactory<Widget>(() => const ItemInfo2Page(),
        instanceName: Routes.itemInfo);
    injector.registerFactory<Widget>(() => QrCodeSharingPage(),
        instanceName: Routes.qrCodeSharing);
  }
}
