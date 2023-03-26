import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../dependencies/app_dependencies.dart';
import 'routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
