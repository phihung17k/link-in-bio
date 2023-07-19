import 'package:flutter/material.dart';
import 'utils/enums.dart';

final _themeLight = ThemeData.light();
final _themeDark = ThemeData.dark();

final appThemeData = {
  AppTheme.light: ThemeData.localize(
      _themeLight, _getLightTextTheme(_themeLight.textTheme)),
  AppTheme.dark:
      ThemeData.localize(_themeDark, _getDarkTextTheme(_themeDark.textTheme)),
  // AppTheme.light: ThemeData(
  //     brightness: Brightness.light,
  //     textTheme: _themeLight.textTheme
  //         .apply(displayColor: Colors.black, bodyColor: Colors.black)
  //  const TextTheme(
  //   bodyLarge: TextStyle(color: Colors.black),
  //   bodyMedium: TextStyle(color: Colors.black),
  //   bodySmall: TextStyle(color: Colors.black),
  //   labelLarge: TextStyle(color: Colors.black),
  //   labelMedium: TextStyle(color: Colors.black),
  //   labelSmall: TextStyle(color: Colors.black),
  //   displayLarge: TextStyle(color: Colors.black),
  //   displayMedium: TextStyle(color: Colors.black),
  //   displaySmall: TextStyle(color: Colors.black),
  //   headlineLarge: TextStyle(color: Colors.black),
  //   headlineMedium: TextStyle(color: Colors.black),
  //   headlineSmall: TextStyle(color: Colors.black),
  //   titleLarge: TextStyle(color: Colors.black),
  //   titleMedium: TextStyle(color: Colors.black),
  //   titleSmall: TextStyle(color: Colors.black),
  // )
  // ),
  // AppTheme.dark:
  //     // _themeDark.copyWith(textTheme: _getDarkTextTheme(_themeDark.textTheme)),
  //     ThemeData(
  //         brightness: Brightness.dark,
  //         textTheme: _themeDark.textTheme
  //             .apply(displayColor: Colors.white, bodyColor: Colors.white)
  // const TextTheme(
  //   bodyLarge: TextStyle(color: Colors.white),
  //   bodyMedium: TextStyle(color: Colors.white),
  //   bodySmall: TextStyle(color: Colors.white),
  //   labelLarge: TextStyle(color: Colors.white),
  //   labelMedium: TextStyle(color: Colors.white),
  //   labelSmall: TextStyle(color: Colors.white),
  //   displayLarge: TextStyle(color: Colors.white),
  //   displayMedium: TextStyle(color: Colors.white),
  //   displaySmall: TextStyle(color: Colors.white),
  //   headlineLarge: TextStyle(color: Colors.white),
  //   headlineMedium: TextStyle(color: Colors.white),
  //   headlineSmall: TextStyle(color: Colors.white),
  //   titleLarge: TextStyle(color: Colors.white),
  //   titleMedium: TextStyle(color: Colors.white),
  //   titleSmall: TextStyle(color: Colors.white),
  // )
  // ),
};

TextTheme _getLightTextTheme(TextTheme base) {
  return base.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
      decorationColor: Colors.black);
  // base.copyWith(
  //   bodyLarge: base.bodyLarge?.copyWith(color: Colors.black),
  //   bodyMedium: base.bodyMedium?.copyWith(color: Colors.black),
  //   bodySmall: base.bodySmall?.copyWith(color: Colors.black),
  //   labelLarge: base.labelLarge?.copyWith(color: Colors.black),
  //   labelMedium: base.labelMedium?.copyWith(color: Colors.black),
  //   labelSmall: base.labelSmall?.copyWith(color: Colors.black),
  //   displayLarge: base.displayLarge?.copyWith(color: Colors.black),
  //   displayMedium: base.displayMedium?.copyWith(color: Colors.black),
  //   displaySmall: base.displaySmall?.copyWith(color: Colors.black),
  //   headlineLarge: base.headlineLarge?.copyWith(color: Colors.black),
  //   headlineMedium: base.headlineMedium?.copyWith(color: Colors.black),
  //   headlineSmall: base.headlineSmall?.copyWith(color: Colors.black),
  //   titleLarge: base.titleLarge?.copyWith(color: Colors.black),
  //   titleMedium: base.titleMedium?.copyWith(color: Colors.black),
  //   titleSmall: base.titleSmall?.copyWith(color: Colors.black),
  // );
}

TextTheme _getDarkTextTheme(TextTheme base) {
  return base.apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
      decorationColor: Colors.white);
  // base.copyWith(
  //   bodyLarge: base.bodyLarge?.copyWith(color: Colors.white),
  //   bodyMedium: base.bodyMedium?.copyWith(color: Colors.white),
  //   bodySmall: base.bodySmall?.copyWith(color: Colors.white),
  //   labelLarge: base.labelLarge?.copyWith(color: Colors.white),
  //   labelMedium: base.labelMedium?.copyWith(color: Colors.white),
  //   labelSmall: base.labelSmall?.copyWith(color: Colors.white),
  //   displayLarge: base.displayLarge?.copyWith(color: Colors.white),
  //   displayMedium: base.displayMedium?.copyWith(color: Colors.white),
  //   displaySmall: base.displaySmall?.copyWith(color: Colors.white),
  //   headlineLarge: base.headlineLarge?.copyWith(color: Colors.white),
  //   headlineMedium: base.headlineMedium?.copyWith(color: Colors.white),
  //   headlineSmall: base.headlineSmall?.copyWith(color: Colors.white),
  //   titleLarge: base.titleLarge?.copyWith(color: Colors.white),
  //   titleMedium: base.titleMedium?.copyWith(color: Colors.white),
  //   titleSmall: base.titleSmall?.copyWith(color: Colors.white),
  // );
}
