import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  // NetworkConnectivity._();
  // static final _instance = NetworkConnectivity._();
  // static NetworkConnectivity get instance => _instance;

  final Connectivity _networkConnectivity = Connectivity();
  final StreamController<Map<ConnectivityResult, bool>> _controller =
      StreamController.broadcast();

  Stream<Map<ConnectivityResult, bool>> get connectionStream =>
      _controller.stream;

  void initialize() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();

    _checkStatus(result);

    _networkConnectivity.onConnectivityChanged.listen((event) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final list = await InternetAddress.lookup('example.com');
      isOnline = list.isNotEmpty && list[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void dispose() {
    _controller.close();
  }
}
