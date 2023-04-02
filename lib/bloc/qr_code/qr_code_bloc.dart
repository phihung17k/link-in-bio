import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/utils/encryption.dart';
import 'package:link_in_bio/utils/native_communication.dart';
import '../../utils/enums.dart';
import '../base_bloc.dart';
import '../../bloc/qr_code/qr_code_event.dart';
import '../../bloc/qr_code/qr_code_state.dart';

class QRCodeBloc extends BaseBloc<QRCodeEvent, QRCodeState> {
  QRCodeBloc()
      : super(const QRCodeState(
            internetInfo: InternetStatusEnum.unknown,
            items: [],
            appQR: "",
            webQR: "")) {
    on<SetInternetInfoEvent>(_checkInternet);
    on<SetAppQREvent>(_setAppQR);
    on<SetWebQREvent>(_setWebQR);
  }

  FutureOr<void> _checkInternet(
      SetInternetInfoEvent event, Emitter<QRCodeState> emit) {
    emit.call(state.copyWith(
        internetInfo: event.info.values.first
            ? InternetStatusEnum.connected
            : InternetStatusEnum.notConnect));
  }

  FutureOr<void> _setAppQR(SetAppQREvent event, Emitter<QRCodeState> emit) {
    Encryption encryption = Encryption();
    String appQR = encryption.encode(event.items);
    emit.call(state.copyWith(items: event.items, appQR: appQR));
  }

  FutureOr<void> _setWebQR(
      SetWebQREvent event, Emitter<QRCodeState> emit) async {
    // store data on firestore
    if (state.internetInfo == InternetStatusEnum.connected) {
      // get android id
      String androidId = await NativeCommunication.getAndroidId();
      FirebaseFirestore db = FirebaseFirestore.instance;
      Map<String, String> data = {
        'data': state.appQR!,
        'time': DateTime.now().toString()
      };
      try {
        DocumentReference doc = await db.collection(androidId).add(data);
        emit.call(state.copyWith(
            webQR: "https://wwww.link-in-bio.com/$androidId/${doc.id}"));
      } catch (e) {
        log("Upload data to firestore fail: $e");
      }
    }
  }
}
