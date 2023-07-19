import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/app_theme.dart';
import 'package:link_in_bio/bloc/theme/theme_bloc.dart';
import 'package:link_in_bio/bloc/theme/theme_event.dart';
import 'package:link_in_bio/utils/enums.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    ThemeBloc themeBloc = BlocProvider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
      ),
      body: Center(
          child: Switch(
        value: themeBloc.state.themeData == appThemeData[AppTheme.light],
        onChanged: (value) {
          var theme = AppTheme.light;
          if (themeBloc.state.themeData == appThemeData[AppTheme.light]) {
            theme = AppTheme.dark;
          }
          themeBloc.add(SwitchingThemeEvent(theme));
        },
      )),
    );
  }
}
