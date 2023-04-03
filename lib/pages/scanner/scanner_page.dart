import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_in_bio/bloc/scanner/scanner_bloc.dart';
import 'package:link_in_bio/bloc/scanner/scanner_event.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../models/item_model.dart';
import '../../utils/enums.dart';

class ScannerPage extends StatefulWidget {
  final ScannerBloc bloc;
  const ScannerPage(this.bloc, {super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  ScannerBloc get bloc => widget.bloc;

  late MobileScannerController controller;
  Barcode? barcode;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
        torchEnabled: false,
        formats: [BarcodeFormat.qrCode],
        detectionSpeed: DetectionSpeed.noDuplicates);

    bloc.listenerStream.listen((event) {
      // if (event is ScanMessageEnum) {
      //   if (!mounted) return;
      //   if (event == ScanMessageEnum.success) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Success. QR code found!'),
      //     backgroundColor: Colors.green,
      //     duration: Duration(seconds: 1),
      //   ),
      // );
      //   } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Fail. No QR code found!'),
      //     backgroundColor: Colors.red,
      //     duration: Duration(seconds: 1),
      //   ),
      // );
      //   }
      //   //sleep 1s
      // }
      if (event != null) {
        if (event is List<ItemModel>) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success. QR code found!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 1),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fail. No QR code found!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
        //sleep 1s
      }
    });
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
                decoration: ShapeDecoration(shape: QrScannerOverlayShape()),
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
                              final ImagePicker picker = ImagePicker();
                              // Pick an image
                              final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image != null) {
                                if (await controller.analyzeImage(image.path)) {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('QR code found!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No QR code found!'),
                                      backgroundColor: Colors.red,
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
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor = Colors.white;
  final double borderWidth = 10;
  final Color overlayColor = Colors.black.withOpacity(0.5);
  final double borderRadius = 0;
  final double borderLength = 40;
  final double cutOutWidth = 250;
  final double cutOutHeight = 250;
  final double cutOutBottomOffset = 0;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.top)
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.right, rect.bottom);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;
    final borderOffset = borderWidth / 2;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final boxPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final cutOutRect = Rect.fromLTWH(
      rect.left + width / 2 - cutOutWidth / 2 + borderOffset,
      -cutOutBottomOffset +
          rect.top +
          height / 2 -
          cutOutHeight / 2 +
          borderOffset,
      cutOutWidth - borderOffset * 2,
      cutOutHeight - borderOffset * 2,
    );

    canvas
      ..saveLayer(
        rect,
        backgroundPaint,
      )
      ..drawRect(
        rect,
        backgroundPaint,
      )
      // Draw top right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - borderLength,
          cutOutRect.top,
          cutOutRect.right,
          cutOutRect.top + borderLength,
          topRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw top left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.top,
          cutOutRect.left + borderLength,
          cutOutRect.top + borderLength,
          topLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom right corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.right - borderLength,
          cutOutRect.bottom - borderLength,
          cutOutRect.right,
          cutOutRect.bottom,
          bottomRight: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      // Draw bottom left corner
      ..drawRRect(
        RRect.fromLTRBAndCorners(
          cutOutRect.left,
          cutOutRect.bottom - borderLength,
          cutOutRect.left + borderLength,
          cutOutRect.bottom,
          bottomLeft: Radius.circular(borderRadius),
        ),
        borderPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(
          cutOutRect,
          Radius.circular(borderRadius),
        ),
        boxPaint,
      )
      ..restore();
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape();
  }
}
