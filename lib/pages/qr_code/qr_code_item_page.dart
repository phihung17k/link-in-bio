import 'package:flutter/material.dart';
import '../../utils/link_util.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/item_model.dart';

class QrCodeItemPage extends StatelessWidget {
  const QrCodeItemPage({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(item.name!,
                          style: Theme.of(context).textTheme.headlineMedium),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(width: 0.5, color: Colors.grey)),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Hero(
                            tag: item.name!,
                            child: QrImage(
                                data: LinkUtil.getUriString(item),
                                version: QrVersions.auto)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 20,
                child: ElevatedButton(
                  child: const Text("Back"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
