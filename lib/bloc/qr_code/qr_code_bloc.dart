import 'package:bloc/src/bloc.dart';
import 'dart:async';

import 'package:link_in_bio/bloc/base_bloc.dart';
import 'package:link_in_bio/bloc/qr_code/qr_code_event.dart';
import 'package:link_in_bio/bloc/qr_code/qr_code_state.dart';

class QRCodeBloc extends BaseBloc<QRCodeEvent, QRCodeState> {
  QRCodeBloc() : super(const QRCodeState()) {
    on<SetInternetInfoEvent>(_checkInternet);
  }

  FutureOr<void> _checkInternet(
      SetInternetInfoEvent event, Emitter<QRCodeState> emit) {
    if (event.info.values.first) {
      emit.call(state.copyWith(internetInfo: "Success"));
    } else {
      emit.call(state.copyWith(internetInfo: "Connect internet fail"));
    }
  }
}
