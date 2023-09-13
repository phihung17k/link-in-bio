import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/app_theme.dart';
import '../dependencies/app_dependencies.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_state.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Link In Bio",
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            onGenerateRoute: (settings) => Routes.getRoutes(settings),
            theme: appThemeData[state.appTheme]?.themeData,
          );
        },
      ),
    );
  }
}
