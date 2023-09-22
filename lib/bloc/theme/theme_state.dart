import 'package:equatable/equatable.dart';

import '../../utils/enums.dart';

class ThemeState extends Equatable {
  final AppThemeEnum? appTheme;

  const ThemeState({this.appTheme});

  ThemeState copyWith({AppThemeEnum? appTheme}) {
    return ThemeState(appTheme: appTheme ?? this.appTheme);
  }

  @override
  List<Object?> get props => [appTheme];
}
