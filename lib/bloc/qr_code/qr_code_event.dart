import 'package:connectivity_plus/connectivity_plus.dart';
import '../../models/item_model.dart';

abstract class QRCodeEvent {}

class SetInternetInfoEvent extends QRCodeEvent {
  final Map<ConnectivityResult, bool> info;

  SetInternetInfoEvent(this.info);
}

class SetAppQREvent extends QRCodeEvent {
  final List<ItemModel> items;

  SetAppQREvent(this.items);
}

class SetWebQREvent extends QRCodeEvent {}

class NavigatorBioPreviewPageEvent extends QRCodeEvent {}
