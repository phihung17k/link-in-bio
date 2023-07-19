import '../../utils/enums.dart';

abstract class ThemeEvent {}

class SwitchingThemeEvent extends ThemeEvent {
  final AppTheme? newTheme;

  SwitchingThemeEvent(this.newTheme);
}
