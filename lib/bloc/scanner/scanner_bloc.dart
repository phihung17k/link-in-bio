import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/scanner/scanner_event.dart';
import '../../bloc/scanner/scanner_state.dart';
import '../../models/item_model.dart';
import '../../routes.dart';
import '../../utils/link_util.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerBloc extends BaseBloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerState(message: "")) {
    on<SaveDetectedQRCodeEvent>(saveDetectedQRCode);
    on<SavePreviousPageEvent>(savePreviousPage);
  }

  FutureOr<void> saveDetectedQRCode(
      SaveDetectedQRCodeEvent event, Emitter<ScannerState> emit) async {
    Barcode barcode = event.barcode.barcodes.first;

    bool decodeSuccess = false;
    if (barcode.format == BarcodeFormat.qrCode &&
        barcode.rawValue != null &&
        barcode.rawValue!.isNotEmpty) {
      try {
        if (state.previousPage == Routes.home) {
          //detect an item model
          ItemModel? item = await LinkUtil.convertQrCode(barcode.rawValue);
          if (item != null) {
            decodeSuccess = true;
            addMessageEvent(item);
          }
        } else if (state.previousPage == Routes.itemInfo) {
          decodeSuccess = true;
          addMessageEvent(barcode);
        }
      } catch (e) {
        log("ScannerBloc: method saveDetectedQRCode: FAIL to convert QR code");
      }
    }

    if (!decodeSuccess) {
      addMessageEvent(null);
    }
  }

  FutureOr<void> savePreviousPage(
      SavePreviousPageEvent event, Emitter<ScannerState> emit) {
    emit.call(state.copyWith(previousPage: event.previousPage));
  }
}
