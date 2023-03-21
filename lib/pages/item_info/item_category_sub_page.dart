import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';
import 'package:link_in_bio/models/item_category_model.dart';

class ItemCategorySubPage extends StatelessWidget {
  const ItemCategorySubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: BlocBuilder<ItemInfoBloc, ItemInfoState>(
        bloc: context.read<ItemInfoBloc>(),
        buildWhen: (previous, current) {
          return previous.itemCategories != current.itemCategories;
        },
        builder: (context, state) {
          if (state.itemCategories == null || state.itemCategories!.isEmpty) {
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
              ItemCategoryModel selectedCategory = state.itemCategories![index];
              return InkWell(
                onTap: () {
                  context
                      .read<ItemInfoBloc>()
                      .add(SetCategoryIndexEvent(selectedCategoryIndex: index));
                },
                highlightColor: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    context.read<ItemInfoBloc>().add(
                        SetCategoryIndexEvent(selectedCategoryIndex: index));
                  },
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
                            Flexible(
                              child: Image.asset(
                                selectedCategory.imageURL!,
                                // width: MediaQuery.of(context).size.width / 5,
                                // height: MediaQuery.of(context).size.width / 5,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(selectedCategory.name!)
                          ]),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            DefaultTabController.of(context).animateTo(1);
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }
}
