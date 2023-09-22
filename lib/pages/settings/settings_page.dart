import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: Column(
          children: [
            for (AppThemeEnum theme in AppThemeEnum.values)
              RadioListTile(
                value: theme,
                groupValue: themeBloc.state.appTheme,
                onChanged: (value) {
                  themeBloc.add(SwitchingThemeEvent(value as AppThemeEnum));
                },
                title: Text(theme.name),
              )
          ],
        ),
      ),
    );
  }
}
