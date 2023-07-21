import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'utils/enums.dart';

class AppThemeData {
  final AppThemeEnum? theme;
  final ThemeData? themeData;
  final Color? color;
  final Color? backgroundColor;

  AppThemeData(
      {required this.theme,
      required this.themeData,
      this.color,
      this.backgroundColor});

  AppThemeData copyWith(
      {AppThemeEnum? theme,
      ThemeData? themeData,
      Color? color,
      Color? backgroundColor}) {
    return AppThemeData(
        theme: theme ?? this.theme,
        themeData: themeData ?? this.themeData,
        color: color ?? this.color ?? themeData?.primaryColor,
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  // @override
  // bool operator ==(Object other) =>
  //     other is AppTheme &&
  //     other.runtimeType == runtimeType &&
  //     other.theme == value;

  // @override
  // int get hashCode => value.hashCode;
}

final _themeLight = ThemeData.light();
final _themeDark = ThemeData.dark();

final appThemeData = {
  AppThemeEnum.light: AppThemeData(
    theme: AppThemeEnum.light,
    themeData: ThemeData.localize(
      _themeLight.copyWith(),
      // _getLightTextTheme(_themeLight.textTheme),
      _themeLight.textTheme,
    ),
    color: _themeLight.primaryColor,
    backgroundColor: Colors.cyan,
  ),
  AppThemeEnum.dark: AppThemeData(
    theme: AppThemeEnum.dark,
    themeData: ThemeData.localize(
      _themeDark,
      // _getDarkTextTheme(_themeDark.textTheme),
      _themeDark.textTheme,
    ),
    color: _themeDark.primaryColor,
    backgroundColor: _themeDark.primaryColorLight,
  ),
  // AppThemeEnum.pink: AppThemeData(
  //   theme: AppThemeEnum.pink,
  // themeData: ThemeData.localize(
  //   ThemeData.raw(
  //       applyElevationOverlayColor: true,
  //       cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
  //           brightness:
  //               ThemeData.estimateBrightnessForColor(Color.fromHex())),
  //       extensions: extensions,
  //       inputDecorationTheme: inputDecorationTheme,
  //       materialTapTargetSize: materialTapTargetSize,
  //       pageTransitionsTheme: pageTransitionsTheme,
  //       platform: platform,
  //       scrollbarTheme: scrollbarTheme,
  //       splashFactory: splashFactory,
  //       useMaterial3: useMaterial3,
  //       visualDensity: visualDensity,
  //       canvasColor: canvasColor,
  //       cardColor: cardColor,
  //       colorScheme: colorScheme,
  //       dialogBackgroundColor: dialogBackgroundColor,
  //       disabledColor: disabledColor,
  //       dividerColor: dividerColor,
  //       focusColor: focusColor,
  //       highlightColor: highlightColor,
  //       hintColor: hintColor,
  //       hoverColor: hoverColor,
  //       indicatorColor: indicatorColor,
  //       primaryColor: primaryColor,
  //       primaryColorDark: primaryColorDark,
  //       primaryColorLight: primaryColorLight,
  //       scaffoldBackgroundColor: scaffoldBackgroundColor,
  //       secondaryHeaderColor: secondaryHeaderColor,
  //       shadowColor: shadowColor,
  //       splashColor: splashColor,
  //       unselectedWidgetColor: unselectedWidgetColor,
  //       iconTheme: iconTheme,
  //       primaryIconTheme: primaryIconTheme,
  //       primaryTextTheme: primaryTextTheme,
  //       textTheme: textTheme,
  //       typography: typography,
  //       appBarTheme: appBarTheme,
  //       badgeTheme: badgeTheme,
  //       bannerTheme: bannerTheme,
  //       bottomAppBarTheme: bottomAppBarTheme,
  //       bottomNavigationBarTheme: bottomNavigationBarTheme,
  //       bottomSheetTheme: bottomSheetTheme,
  //       buttonBarTheme: buttonBarTheme,
  //       buttonTheme: buttonTheme,
  //       cardTheme: cardTheme,
  //       checkboxTheme: checkboxTheme,
  //       chipTheme: chipTheme,
  //       dataTableTheme: dataTableTheme,
  //       dialogTheme: dialogTheme,
  //       dividerTheme: dividerTheme,
  //       drawerTheme: drawerTheme,
  //       dropdownMenuTheme: dropdownMenuTheme,
  //       elevatedButtonTheme: elevatedButtonTheme,
  //       expansionTileTheme: expansionTileTheme,
  //       filledButtonTheme: filledButtonTheme,
  //       floatingActionButtonTheme: floatingActionButtonTheme,
  //       iconButtonTheme: iconButtonTheme,
  //       listTileTheme: listTileTheme,
  //       menuBarTheme: menuBarTheme,
  //       menuButtonTheme: menuButtonTheme,
  //       menuTheme: menuTheme,
  //       navigationBarTheme: navigationBarTheme,
  //       navigationDrawerTheme: navigationDrawerTheme,
  //       navigationRailTheme: navigationRailTheme,
  //       outlinedButtonTheme: outlinedButtonTheme,
  //       popupMenuTheme: popupMenuTheme,
  //       progressIndicatorTheme: progressIndicatorTheme,
  //       radioTheme: radioTheme,
  //       segmentedButtonTheme: segmentedButtonTheme,
  //       sliderTheme: sliderTheme,
  //       snackBarTheme: snackBarTheme,
  //       switchTheme: switchTheme,
  //       tabBarTheme: tabBarTheme,
  //       textButtonTheme: textButtonTheme,
  //       textSelectionTheme: textSelectionTheme,
  //       timePickerTheme: timePickerTheme,
  //       toggleButtonsTheme: toggleButtonsTheme,
  //       tooltipTheme: tooltipTheme),
  //   // _getDarkTextTheme(_themeDark.textTheme),
  //   _themeDark.textTheme,
  // ),
  // ),
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
