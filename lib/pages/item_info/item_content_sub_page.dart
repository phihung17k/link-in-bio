import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/pages/item_info/widgets/email_card.dart';
import 'package:link_in_bio/pages/item_info/widgets/sms_card.dart';
import 'package:link_in_bio/pages/item_info/widgets/wifi_card.dart';
import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../bloc/item_info/item_info_state.dart';
import '../../models/models.dart';
import 'widgets/item_detail_card.dart';
import 'widgets/item_label_card.dart';

class ItemContentSubPage extends StatefulWidget {
  final String? initialName;
  final String? initialURL;
  const ItemContentSubPage({super.key, this.initialName, this.initialURL});

  @override
  State<ItemContentSubPage> createState() => _ItemContentSubPageState();
}

class _ItemContentSubPageState extends State<ItemContentSubPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController urlController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController bccController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  TextEditingController networkNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ItemInfoBloc? bloc;

  void initValue(ItemModel item) {
    switch (item.category!.name!.toLowerCase()) {
      case "sms":
        SmsModel? sms = item.sms;
        phoneNumberController.text = sms?.phoneNumber ?? "";
        messageController.text = sms?.message ?? "";
        break;
      case "facebook":
      case "twitter":
      case "youtube":
      case "tiktok":
      case "twitch":
        UrlModel? url = item.url;
        urlController.text = url?.url ?? "";
        break;
      case "phone":
        PhoneModel? phone = item.phone;
        phoneNumberController.text = phone?.phoneNumber ?? "";
        break;
      case "email":
        EmailModel? email = item.email;
        addressController.text = email?.address ?? "";
        ccController.text = email?.cc ?? "";
        bccController.text = email?.bcc ?? "";
        subjectController.text = email?.subject ?? "";
        bodyController.text = email?.body ?? "";
        break;
      case "wifi":
        WifiModel? wifi = item.wifi;
        networkNameController.text = wifi?.networkName ?? "";
        passwordController.text = wifi?.password ?? "";
        bloc?.add(SetNetworkEncryptionEvent(wifi?.encryption));
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ItemInfoBloc>();

    ItemModel? item = bloc!.state.item;
    if (item != null) {
      String? initialName = item.name;
      if (initialName != null) nameController.text = initialName;
      initValue(item);
    }
  }

  Widget getItemDetailCard(ItemCategoryModel category) {
    Widget result;
    switch (category.name!.toLowerCase()) {
      case "sms":
        result = SmsCard(
          phoneNumerController: phoneNumberController,
          messageController: messageController,
          category: category,
        );
        break;
      case "facebook":
      case "twitter":
      case "youtube":
      case "tiktok":
      case "twitch":
        result = ItemDetailCard(
          textController: urlController,
          category: category,
          label: "URL",
          showDetailLink: true,
        );
        break;
      case "phone":
        result = ItemDetailCard(
            textController: phoneNumberController,
            category: category,
            label: "Phone");
        break;
      case "email":
        result = EmailCard(
            addressController: addressController,
            ccController: ccController,
            bccController: bccController,
            subjectController: subjectController,
            bodyController: bodyController,
            category: category);
        break;
      case 'wifi':
        result = WifiCard(
            networkNameController: networkNameController,
            passwordController: passwordController);
        break;
      default:
        result = const SizedBox();
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: BlocBuilder<ItemInfoBloc, ItemInfoState>(
          bloc: bloc,
          buildWhen: (previous, current) {
            return previous.selectedCategoryIndex !=
                current.selectedCategoryIndex;
          },
          builder: (context, state) {
            ItemCategoryModel category =
                state.itemCategories![state.selectedCategoryIndex!];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemLabelCard(
                    nameTextController: nameController,
                    label: category.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  getItemDetailCard(category),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                      Text("Or", style: Theme.of(context).textTheme.titleLarge),
                      const Expanded(
                          child: Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 2,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            bloc!
                                .addNavigatedEvent(NavigatorScannerPageEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5))),
                          child: const Text("Scan QR",
                              style: TextStyle(
                                  inherit: false, color: Colors.black)))),
                  const SizedBox(
                    height: 20,
                  ),
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: toString(),
          onPressed: () {
            bloc!.add(SetItemInfoEvent(
                name: nameController.text,
                phoneNumber: phoneNumberController.text,
                message: messageController.text,
                url: urlController.text,
                address: addressController.text,
                bcc: bccController.text,
                cc: ccController.text,
                subject: subjectController.text,
                body: bodyController.text,
                networkName: networkNameController.text,
                password: passwordController.text));
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    messageController.dispose();
    urlController.dispose();

    addressController.dispose();
    bccController.dispose();
    ccController.dispose();
    subjectController.dispose();
    bodyController.dispose();

    networkNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
