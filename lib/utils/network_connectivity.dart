import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  // NetworkConnectivity._();
  // static final _instance = NetworkConnectivity._();
  // static NetworkConnectivity get instance => _instance;

  final Connectivity _networkConnectivity = Connectivity();
  final StreamController _controller = StreamController.broadcast();

  Stream get connectionStream => _controller.stream;

  dynamic x;

  void initialize() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();

    _checkStatus(result);

    _networkConnectivity.onConnectivityChanged.listen((event) {
      print(event);
      x = event;
    });
  }

  // void _checkStatus() async {
  //   bool isOnline = false;
  //   try {
  //     List<InternetAddress> list = await InternetAddress.lookup('example.com');
  //     if (list.isNotEmpty) {
  //       isOnline = true;
  //     }
  //     print("abc");
  //   } catch (_) {
  //     isOnline = false;
  //   }
  //   _controller.add({result});
  // }
  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final list = await InternetAddress.lookup('example.com');
      isOnline = list.isNotEmpty && list[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      isOnline = false;
      print(e);
    }
    _controller.sink.add({result: isOnline});
  }
}
