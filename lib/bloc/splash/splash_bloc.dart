import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/i_services/i_splash_service.dart';
import '../base_bloc.dart';
import 'dart:async';
import 'package:link_in_bio/bloc/splash/splash_event.dart';
import 'package:link_in_bio/bloc/splash/splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  final ISplashService _service;
  SplashBloc(this._service) : super(const SplashState()) {
    on<InitialDataEvent>(_initData);
  }

  FutureOr<void> _initData(
      InitialDataEvent event, Emitter<SplashState> emit) async {
    await _service.initData();
    addNavigatedEvent(NavigatorToHomePageEvent());
  }
}
