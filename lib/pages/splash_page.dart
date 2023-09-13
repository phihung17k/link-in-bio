import 'package:flutter/material.dart';
import 'package:link_in_bio/bloc/splash/splash_event.dart';
import '../bloc/splash/splash_bloc.dart';
import '../routes.dart';
import 'loading_widget.dart';

class SplashPage extends StatefulWidget {
  final SplashBloc bloc;

  const SplashPage(this.bloc, {super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();

    bloc.listenerStream.listen((event) {
      if (event is NavigatorToHomePageEvent) {
        Navigator.pushReplacementNamed(context, Routes.home,
            arguments: event.items);
      }
    });

    bloc.add(InitialDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
