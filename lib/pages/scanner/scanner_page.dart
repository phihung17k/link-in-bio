import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_in_bio/bloc/scanner/scanner_bloc.dart';
import 'package:link_in_bio/bloc/scanner/scanner_event.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../models/item_model.dart';
import '../../routes.dart';
import '../../utils/gallery.dart';
import 'scanner_overlay.dart';

class ScannerPage extends StatefulWidget {
  final ScannerBloc bloc;
  const ScannerPage(this.bloc, {super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScannerBloc get bloc => widget.bloc;
  late MobileScannerController controller;
  bool isCall = true;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
        torchEnabled: false,
        formats: [BarcodeFormat.qrCode],
        detectionSpeed: DetectionSpeed.noDuplicates);
    bloc.listenerStream.listen((event) async {
      if (isCall) {
        if (event != null) {
          // if (event is List<ItemModel>) {
          isCall = false;
          ScaffoldMessengerState scaffoldMessenger =
              ScaffoldMessenger.of(context);
          scaffoldMessenger
              .showSnackBar(
                const SnackBar(
                  content: Text('Success. QR code found!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                ),
              )
              .closed
              .then((_) async {
            if (mounted) {
              if (event is ItemModel) {
                Navigator.pop(context, event);
              } else if (event is List<ItemModel>) {
                await Navigator.pushNamed(
                  context,
                  Routes.bioPreview,
                  // ModalRoute.withName(Routes.home),
                  arguments: event,
                );
              } else if (event is Barcode) {
                Navigator.pop(context, event);
              }
              isCall = true;
            }
          });
          // }
        } else {
          isCall = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                  content: Text('Fail. Invalid QR code'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 1),
                ),
              )
              .closed
              .then((_) => isCall = true);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is String) {
      bloc.add(SavePreviousPageEvent(setting.arguments as String));
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              MobileScanner(
                controller: controller,
                errorBuilder: (context, error, child) {
                  return Text("error $Error");
                },
                fit: BoxFit.contain,
                onDetect: (barcode) {
                  bloc.add(SaveDetectedQRCodeEvent(barcode));
                },
                scanWindow: scanWindow,
                placeholderBuilder: (p0, p1) => SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text("Waiting camera",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ),
              Container(
                decoration: ShapeDecoration(shape: ScannerOverlayShape()),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: ValueListenableBuilder(
                              valueListenable: controller.torchState,
                              builder: (context, state, child) {
                                switch (state) {
                                  case TorchState.off:
                                    return const Icon(
                                      Icons.flash_off,
                                      color: Colors.grey,
                                    );
                                  case TorchState.on:
                                    return const Icon(
                                      Icons.flash_on,
                                      color: Colors.yellow,
                                    );
                                }
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.toggleTorch(),
                          ),
                          Text("flash light",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: ValueListenableBuilder(
                              valueListenable: controller.cameraFacingState,
                              builder: (context, state, child) {
                                return Icon(state == CameraFacing.front
                                    ? Icons.camera_front
                                    : Icons.camera_rear);
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.switchCamera(),
                          ),
                          ValueListenableBuilder(
                              valueListenable: controller.cameraFacingState,
                              builder: (context, state, child) {
                                return Text(
                                    state == CameraFacing.front
                                        ? "front camera"
                                        : "back camera",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: Colors.white));
                              })
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.image),
                            iconSize: 32.0,
                            onPressed: () async {
                              XFile? image = await Gallery.pickImage();
                              if (image != null) {
                                if (await controller.analyzeImage(image.path)) {
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No QR code found!'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Text("Image",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    controller.dispose();
    bloc.close();
    super.dispose();
  }
}
