import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../base_bloc.dart';
import '../../bloc/qr_code/qr_code_event.dart';
import '../../bloc/qr_code/qr_code_state.dart';

class QRCodeBloc extends BaseBloc<QRCodeEvent, QRCodeState> {
  QRCodeBloc()
      : super(const QRCodeState(internetInfo: "", items: [], qrData: "")) {
    on<SetInternetInfoEvent>(_checkInternet);
    on<SetQRData>(_setQRData);
  }

  FutureOr<void> _checkInternet(
      SetInternetInfoEvent event, Emitter<QRCodeState> emit) {
    if (event.info.values.first) {
      emit.call(state.copyWith(internetInfo: "Success"));
    } else {
      emit.call(state.copyWith(internetInfo: "Connect internet fail"));
    }
  }

  FutureOr<void> _setQRData(SetQRData event, Emitter<QRCodeState> emit) {
    String itemListString = jsonEncode(event.items);
    String base64 = base64Encode(utf8.encode(itemListString));
    emit.call(state.copyWith(items: event.items, qrData: base64));
  }
}
