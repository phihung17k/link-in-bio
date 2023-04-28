import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/pages/item_info/widgets/sms_card.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../bloc/item_info/item_info_state.dart';
import '../../../models/item_category_model.dart';
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
  TextEditingController? nameTextController;
  TextEditingController? urlTextController;

  ItemInfoBloc? bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ItemInfoBloc>();
    String? initialName = bloc?.state.item?.name;
    String? initialURL = bloc?.state.item?.url;
    nameTextController = TextEditingController(text: initialName);
    urlTextController = TextEditingController(text: initialURL);
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
                          urlTextController: urlTextController,
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
                                  inherit: false, color: Colors.black))))
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: toString(),
          onPressed: () {
            // bloc!.addNavigatedEvent(BackingHomePageEvent());
            if (bloc!.state.item!.category!.name == "SMS") {
              bloc!.add(SetSms(phoneNumber: urlTextController!.text));
            } else {
              bloc!.addNavigatedEvent(BackingHomePageEvent());
            }
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }

  @override
  void dispose() {
    urlTextController?.dispose();
    nameTextController?.dispose();
    super.dispose();
  }
}
