import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/qr_code/qr_code_bloc.dart';
import '../../../bloc/qr_code/qr_code_state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeAppWidget extends StatelessWidget {
  const QRCodeAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Center(
        child: BlocBuilder<QRCodeBloc, QRCodeState>(
          bloc: context.read<QRCodeBloc>(),
          buildWhen: (previous, current) {
            return previous.appQR != current.appQR;
          },
          builder: (context, state) {
            return QrImageView(data: state.appQR!, version: QrVersions.auto);
          },
        ),
      ),
    );
  }
}
