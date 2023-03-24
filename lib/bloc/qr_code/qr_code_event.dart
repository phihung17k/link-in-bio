import 'package:connectivity_plus/connectivity_plus.dart';
import '../../models/item_model.dart';

abstract class QRCodeEvent {}

class SetInternetInfoEvent extends QRCodeEvent {
  final Map<ConnectivityResult, bool> info;

  SetInternetInfoEvent(this.info);
}

class SetQRData extends QRCodeEvent {
  final List<ItemModel> items;

  SetQRData(this.items);
}

class NavigatorBioPreviewPageEvent extends QRCodeEvent {}
