import 'package:connectivity_plus/connectivity_plus.dart';

abstract class QRCodeEvent {}

class SetInternetInfoEvent extends QRCodeEvent {
  final Map<ConnectivityResult, bool> info;

  SetInternetInfoEvent(this.info);
}
