import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/base_bloc.dart';
import 'package:link_in_bio/bloc/scanner/scanner_event.dart';
import 'package:link_in_bio/bloc/scanner/scanner_state.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/utils/encryption.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBloc extends BaseBloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState(message: "")) {
    on<SaveDetectedQRCodeEvent>(saveDetectedQRCode);
  }

  FutureOr<void> saveDetectedQRCode(
      SaveDetectedQRCodeEvent event, Emitter<ScannerState> emit) {
    Barcode barcode = event.barcode.barcodes.first;

    bool decodeSuccess = false;
    if (barcode.format == BarcodeFormat.qrCode &&
        barcode.rawValue != null &&
        barcode.rawValue!.isNotEmpty) {
      try {
        //convert to list of item model
        Encryption encryption = Encryption();
        Object? decodeObject = encryption.decode(barcode.rawValue!);
        if (decodeObject != null) {
          List<dynamic> tempItems = decodeObject as List<dynamic>;
          List<ItemModel> items = List<ItemModel>.from(
              tempItems.map((element) => ItemModel.fromMap(element)));
          decodeSuccess = true;
          addMessageEvent(items);
        }
      } catch (e) {
        log("ScannerBloc: method saveDetectedQRCode: FAIL to convert QR code");
      }
    }

    if (!decodeSuccess) {
      addMessageEvent(null);
    }
  }
}
