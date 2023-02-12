import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_in_bio/dependencies/app_dependencies.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.setUp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
    title: "Link In Bio",
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.home,
    onGenerateRoute: (settings) => Routes.getRoutes(settings),
  ));
}
