import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/models/data_model.dart';
import 'package:link_in_bio/pages/item_info/widgets/sms_card.dart';
import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../bloc/item_info/item_info_state.dart';
import '../../../models/item_category_model.dart';
import '../../models/item_model.dart';
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
  TextEditingController nameTextController = TextEditingController();

  TextEditingController urlTextController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  ItemInfoBloc? bloc;

  void initValue(ItemModel item) {
    switch (item.category!.name!.toLowerCase()) {
      case "url":
        break;
      case "sms":
        SmsModel sms = item.sms!;
        phoneNumberController.text = sms.phoneNumber ?? "";
        messageController.text = sms.message ?? "";
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
      if (initialName != null) nameTextController.text = initialName;
      if (item.sms != null) {
        initValue(item);
      }
    }
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
                    nameTextController: nameTextController,
                    label: category.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  category.name == "SMS"
                      ? SmsCard(
                          phoneNumerController: phoneNumberController,
                          messageController: messageController,
                          category: category,
                        )
                      : ItemDetailCard(
                          urlTextController: urlTextController,
                          category: category,
                        ),
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
            bloc!.add(SetItemInfo(
              phoneNumber: phoneNumberController.text,
              message: messageController.text,
            ));
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    messageController.dispose();
    urlTextController.dispose();
    nameTextController.dispose();
    super.dispose();
  }
}
