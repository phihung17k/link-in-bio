import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../bloc/qr_code/qr_code_bloc.dart';
import '../../../bloc/qr_code/qr_code_state.dart';
import '../../../utils/enums.dart';

class QRCodeWebWidget extends StatelessWidget {
  const QRCodeWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: BlocBuilder<QRCodeBloc, QRCodeState>(
          bloc: context.read<QRCodeBloc>(),
          buildWhen: (previous, current) {
            return previous.webQR != current.webQR;
          },
          builder: (context, state) {
            switch (state.internetInfo) {
              case InternetStatusEnum.connected:
                return QrImage(data: state.webQR!, version: QrVersions.auto);
              case InternetStatusEnum.notConnect:
                return const Text("Connect internet fail");
              default:
                return const Text("Waiting for internet");
            }
            // return AnimatedOpacity(
            //     opacity: state.webQR!.isNotEmpty ? 1.0 : 0.0,
            //     duration: const Duration(milliseconds: 500),
            //     child: QrImage(data: state.webQR!, version: QrVersions.auto));
          },
        ),
      ),
    );
  }
}
