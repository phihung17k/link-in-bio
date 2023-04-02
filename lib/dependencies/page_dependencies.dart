import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../pages/pages.dart';
import '../routes.dart';
import '../pages/item_info/item_info_page.dart';

class PageDependencies {
  static Future setUp(GetIt injector) async {
    injector.registerFactory<Widget>(() => HomePage(injector()),
        instanceName: Routes.home);
    injector.registerFactory<Widget>(() => ItemInfoPage(injector()),
        instanceName: Routes.itemInfo);
    injector.registerFactory<Widget>(() => QRCodeSharingPage(injector()),
        instanceName: Routes.qrCodeSharing);
    injector.registerFactory<Widget>(() => BioPreviewPage(injector()),
        instanceName: Routes.bioPreview);
    injector.registerFactory<Widget>(() => ScannerPage(),
        instanceName: Routes.scanner);
  }
}
