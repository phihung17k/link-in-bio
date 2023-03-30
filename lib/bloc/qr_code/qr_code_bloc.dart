import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/utils/encryption.dart';
import 'package:link_in_bio/utils/native_communication.dart';
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

  FutureOr<void> _setQRData(SetQRData event, Emitter<QRCodeState> emit) async {
    Encryption encryption = Encryption();
    String base64 = encryption.encode(event.items);
    // String itemListString = jsonEncode(event.items);
    // String base64 = base64Encode(utf8.encode(itemListString));

    // store data on firestore
    // FirebaseInstallations

    // get android id
    String androidId = await NativeCommunication.getAndroidId();
    print("android id $androidId");

    emit.call(state.copyWith(items: event.items, qrData: base64));
  }
}
