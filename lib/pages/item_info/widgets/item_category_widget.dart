import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../models/item_category_model.dart';

class ItemCategoryWidget extends StatelessWidget {
  const ItemCategoryWidget({
    super.key,
    required this.index,
    required this.selectedCategory,
  });

  final int index;
  final ItemCategoryModel selectedCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ItemInfoBloc>()
            .add(SetCategoryIndexEvent(selectedCategoryIndex: index));
      },
      child: Card(
        elevation: 2,
        shape:
            context.watch<ItemInfoBloc>().state.selectedCategoryIndex == index
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
                  child: Image.asset(selectedCategory.image!),
                ),
                const SizedBox(height: 5),
                Text(selectedCategory.name!)
              ]),
        ),
      ),
    );
  }
}
