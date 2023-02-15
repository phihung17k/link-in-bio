import 'dart:async';

import 'package:flutter/material.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/pages/qrcode_sharing_page.dart';
import 'package:link_in_bio/routes.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../app_icons.dart';
import '../../utils/pop_with_results.dart';

class ItemContentSubPage extends StatefulWidget {
  const ItemContentSubPage({super.key});

  @override
  State<ItemContentSubPage> createState() => _ItemContentSubPageState();
}

class _ItemContentSubPageState extends State<ItemContentSubPage> {
  TextEditingController? textController;
  bool isValidateTextField = true;

  ItemModel? item;

  Timer? debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    textController = TextEditingController();

    // item =
    //     ItemModel(name: "Test", symbolPath: "assets/images/default_avatar.png");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null) {
      if (setting.arguments is ItemModel) {
        item = setting.arguments as ItemModel;
        if (item!.url != null) {
          textController!.text = item!.url!;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input item information"),
        centerTitle: true,
        actions: [
          if (textController!.text.isNotEmpty)
            InkWell(
              onTap: () {
                // Navigator.pushReplacementNamed(context, Routes.qrCodeSharing,
                //     arguments: );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrCodeSharingPage(
                        item: ItemModel(
                            name: item!.name!,
                            category: item!.category,
                            url: textController?.text ?? ""),
                      ),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(children: [
                  Icon(AppIcons.share, size: 20),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Share")
                ]),
              ),
            )
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          child: item != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(item!.category!),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(item!.name!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: textController!,
                      autofocus: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: 'Enter the Value',
                        errorText: isValidateTextField
                            ? null
                            : 'Field cannot be empty',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.solid, width: 1)),
                      ),
                      onChanged: (value) {
                        if (debounce?.isActive ?? false) debounce?.cancel();
                        debounce = Timer(
                          Duration(milliseconds: 500),
                          () {
                            setState(() {});
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        heightFactor: 0.5,
                        child: Align(
                          alignment: Alignment.center,
                          child: QrImage(
                            data: textController?.text ?? "",
                            version: QrVersions.auto,
                            embeddedImage:
                                AssetImage("assets/images/default_avatar.png"),
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
                          if (textController!.text.isEmpty) {
                            setState(() {
                              isValidateTextField = false;
                            });
                          } else {
                            if (item!.url == null) {
                              Navigator.of(context).pop(
                                  PopWithResults<ItemModel>(
                                      fromPage: Routes.itemInfo,
                                      toPage: Routes.home,
                                      result: ItemModel(
                                          name: item!.name!,
                                          category: item!.category,
                                          url: textController!.text)));
                            } else {
                              // Navigator.of(context).pop(ItemModel(
                              //     name: item!.name!,
                              //     symbolPath: item!.symbolPath,
                              //     url: textController!.text));

                              Navigator.of(context).pop(
                                  PopWithResults<ItemModel>(
                                      fromPage: Routes.itemInfo,
                                      toPage: Routes.home,
                                      result: ItemModel(
                                          name: item!.name!,
                                          category: item!.category,
                                          url: textController!.text)));
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item!.url == null ? "Create" : " Update",
                          ),
                        )),
                  ],
                )
              : SizedBox()),
    );
  }
}
