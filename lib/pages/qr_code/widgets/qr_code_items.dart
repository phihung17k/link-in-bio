import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/qr_code/qr_code_bloc.dart';
import '../../../models/item_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../bloc/qr_code/qr_code_state.dart';
import '../qr_code_item_page.dart';

class QRCodeItemsWidget extends StatelessWidget {
  const QRCodeItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QRCodeBloc, QRCodeState>(
      bloc: context.read<QRCodeBloc>(),
      buildWhen: (previous, current) {
        return previous.items != current.items;
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.items!.length,
          itemBuilder: (context, index) {
            ItemModel item = state.items![index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 0.5, color: Colors.grey)),
                child: ListTile(
                    title: Text(item.name!),
                    trailing: QrImage(
                        data: "${item.category!.webUrl}${item.url}",
                        version: QrVersions.auto),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                            builder: (BuildContext context) {
                          return QrCodeItemPage(item: item);
                        }),
                      );
                    }),
              ),
            );
          },
        );
      },
    );
  }
}
