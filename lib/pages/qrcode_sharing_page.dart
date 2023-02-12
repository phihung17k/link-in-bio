import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/item_model.dart';

class QrCodeSharingPage extends StatelessWidget {
  final ItemModel? item;
  const QrCodeSharingPage({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: size.height / 10,
          ),
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/default_avatar.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 10,
          ),
          Text("Personal information"),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FractionallySizedBox(
              heightFactor: 0.5,
              child: Align(
                alignment: Alignment.center,
                child: QrImage(
                  data: item!.url!,
                  version: QrVersions.auto,
                  embeddedImage: AssetImage("assets/images/default_avatar.png"),
                ),
              ),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Back"),
              )),
        ]),
      ),
    );
  }
}
