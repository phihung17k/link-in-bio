import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/item_info/item_info_bloc.dart';
import '../../bloc/item_info/item_info_state.dart';
import '../../models/item_category_model.dart';
import 'widgets/item_category_widget.dart';

class ItemCategorySubPage extends StatefulWidget {
  const ItemCategorySubPage({super.key});

  @override
  State<ItemCategorySubPage> createState() => _ItemCategorySubPageState();
}

class _ItemCategorySubPageState extends State<ItemCategorySubPage> {
  late ItemInfoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ItemInfoBloc>();
  }

  List<List<ItemCategoryModel>> getCategoryTopics(
      List<ItemCategoryModel> itemCategories) {
    List<List<ItemCategoryModel>> results = [];
    String topic = itemCategories[0].topic!;
    List<ItemCategoryModel> tempList = [];
    for (var category in itemCategories) {
      if (category.topic == topic) {
        tempList.add(category);
      } else {
        results.add(tempList.toList());
        tempList.clear();
        topic = category.topic!;
        tempList.add(category);
      }
    }
    results.add(tempList);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: BlocBuilder<ItemInfoBloc, ItemInfoState>(
        bloc: bloc,
        buildWhen: (previous, current) {
          return previous.itemCategories != current.itemCategories;
        },
        builder: (context, state) {
          List<ItemCategoryModel>? itemCategories = state.itemCategories;
          if (itemCategories == null || itemCategories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          var topics = getCategoryTopics(itemCategories);
          return ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, indexCategory) {
              List<ItemCategoryModel> categories = topics[indexCategory];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(categories.first.topic!,
                      style: Theme.of(context).textTheme.titleLarge),
                  const Divider(thickness: 2),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 8 / 7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indexItem) {
                      ItemCategoryModel selectedCategory =
                          categories[indexItem];
                      if (indexCategory > 0) {
                        for (var i = 1; i <= indexCategory; i++) {
                          indexItem += topics[indexCategory - i].length;
                        }
                      }
                      return ItemCategoryWidget(
                          index: indexItem, selectedCategory: selectedCategory);
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: this.toString(),
          onPressed: () {
            DefaultTabController.of(context).animateTo(1);
          },
          child: const Icon(Icons.keyboard_double_arrow_right_rounded)),
    );
  }
}
