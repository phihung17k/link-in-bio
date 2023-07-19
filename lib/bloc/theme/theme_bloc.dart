import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_theme.dart';
import '../../utils/enums.dart';
import '../base_bloc.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends BaseBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeData: appThemeData[AppTheme.light])) {
    on<SwitchingThemeEvent>(changeTheme);
  }

  FutureOr<void> changeTheme(
      SwitchingThemeEvent event, Emitter<ThemeState> emitter) async {
    emitter.call(state.copyWith(themeData: appThemeData[event.newTheme]));
  }
}
