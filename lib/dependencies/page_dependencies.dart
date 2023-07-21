import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:link_in_bio/pages/settings/settings_page.dart';
import '../pages/pages.dart';
import '../routes.dart';

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
    injector.registerFactory<Widget>(() => ScannerPage(injector()),
        instanceName: Routes.scanner);
    injector.registerFactory<Widget>(() => const SettingsPage(),
        instanceName: Routes.setting);
  }
}
