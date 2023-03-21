import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/qr_code/qr_code_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../bloc/qr_code/qr_code_state.dart';

class QRCodeWebWidget extends StatelessWidget {
  const QRCodeWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<QRCodeBloc, QRCodeState>(
      bloc: context.read<QRCodeBloc>(),
      builder: (context, state) {
        if (state.internetInfo == null) {
          return const Text("Waiting for internet");
        }
        return Text(state.internetInfo!);
      },
    ));
  }
}
