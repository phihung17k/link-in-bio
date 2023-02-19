import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';

class ItemCategorySubPage extends StatelessWidget {
  const ItemCategorySubPage({super.key});

  // name, path image
  // final Map<String, String> maps = {
  //   'Facebook': 'assets/images/default_avatar.png',
  //   'Tiktok': 'assets/images/default_avatar.png',
  //   'Zalo': 'assets/images/default_avatar.png',
  //   'Twitter': 'assets/images/default_avatar.png',
  //   'Instagram': 'assets/images/default_avatar.png',
  //   'Youtube': 'assets/images/default_avatar.png',
  //   'Amazon': 'assets/images/default_avatar.png',
  //   'Shopee': 'assets/images/default_avatar.png',
  //   'Lazada': 'assets/images/default_avatar.png',
  //   'Tiki': 'assets/images/default_avatar.png',
  //   'Link': 'assets/images/default_avatar.png',
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: BlocBuilder<ItemInfoBloc, ItemInfoState>(
            bloc: context.read<ItemInfoBloc>(),
            buildWhen: (previous, current) {
              // print(
              //     "previous.itemCategories != current.itemCategories ${previous.itemCategories != current.itemCategories}");
              return previous.itemCategories != current.itemCategories;
            },
            builder: (context, state) {
              if (state.itemCategories == null ||
                  state.itemCategories!.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 8 / 7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: state.itemCategories!.length,
                itemBuilder: (context, index) {
                  ItemCategoryModel selectedCategory =
                      state.itemCategories![index];
                  return InkWell(
                    onTap: () {
                      context.read<ItemInfoBloc>().add(SetItemEvent(
                          category: selectedCategory,
                          selectedCategoryIndex: index,
                          url: ""));
                    },
                    highlightColor: Colors.blue,
                    child: Card(
                      elevation: 2,
                      shape: context
                                  .watch<ItemInfoBloc>()
                                  .state
                                  .selectedCategoryIndex ==
                              index
                          ? const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 3))
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                selectedCategory.imageURL!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.fitHeight,
                              ),
                              Text(selectedCategory.name!)
                            ]),
                      ),
                    ),
                  );
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            DefaultTabController.of(context)!.animateTo(1);
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }
}
