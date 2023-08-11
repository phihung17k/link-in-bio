import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils/color_util.dart';
import 'utils/enums.dart';
import 'utils/extensions.dart';

class AppThemeData {
  final AppThemeEnum? theme;
  final ThemeData? themeData;
  // final Color? color;
  // final Color? backgroundColor;

  AppThemeData({required this.theme, required this.themeData});

  AppThemeData copyWith(
      {AppThemeEnum? theme,
      ThemeData? themeData,
      Color? color,
      Color? backgroundColor}) {
    return AppThemeData(
        theme: theme ?? this.theme, themeData: themeData ?? this.themeData);
  }

  // @override
  // bool operator ==(Object other) =>
  //     other is AppTheme &&
  //     other.runtimeType == runtimeType &&
  //     other.theme == value;

  // @override
  // int get hashCode => value.hashCode;
}

final _lightTheme = ThemeData.light();
final _darkTheme = ThemeData.dark();
final _lightPinkTheme = ThemeData.from(
    colorScheme: ColorSchemes.lightPinkScheme, useMaterial3: true);
final _darkPinkTheme = ThemeData.from(
    colorScheme: ColorSchemes.darkPinkScheme, useMaterial3: true);

final appThemeData = {
  AppThemeEnum.light: AppThemeData(
      theme: AppThemeEnum.light,
      themeData: ThemeData.localize(
        _lightTheme.copyWith(),
        // _getLightTextTheme(_themeLight.textTheme),
        _lightTheme.textTheme,
      )),
  AppThemeEnum.dark: AppThemeData(
      theme: AppThemeEnum.dark,
      themeData: ThemeData.localize(
        _darkTheme,
        _darkTheme.textTheme,
      )),
  AppThemeEnum.lightPink: AppThemeData(
    theme: AppThemeEnum.lightPink,
    themeData: ThemeData.localize(
      _lightPinkTheme,
      _lightPinkTheme.textTheme,
    ),
  ),
  AppThemeEnum.darkPink: AppThemeData(
    theme: AppThemeEnum.darkPink,
    themeData: ThemeData.localize(
      _darkPinkTheme,
      _darkPinkTheme.textTheme,
    ),
  ),
};

TextTheme _getLightTextTheme(TextTheme base) {
  return base.apply(
    displayColor: Colors.black,
    bodyColor: Colors.black,
  );
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
  );
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
