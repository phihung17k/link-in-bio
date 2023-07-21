import '../../utils/enums.dart';

abstract class ThemeEvent {}

class SwitchingThemeEvent extends ThemeEvent {
  final AppThemeEnum? newTheme;

  SwitchingThemeEvent(this.newTheme);
}
