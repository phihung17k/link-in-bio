import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_info/item_info_bloc.dart';
import '../../../bloc/item_info/item_info_event.dart';
import '../../../bloc/item_info/item_info_state.dart';
import '../../../models/item_category_model.dart';

class ItemCategoryWidget extends StatelessWidget {
  final ItemCategoryModel selectedCategory;

  const ItemCategoryWidget({
    super.key,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ItemInfoBloc>().add(
            SelectingCategoryEvent(selectedCategoryId: selectedCategory.id));
      },
      child: BlocBuilder<ItemInfoBloc, ItemInfoState>(
          bloc: context.read<ItemInfoBloc>(),
          buildWhen: (previous, current) {
            return previous.selectedCategoryId != current.selectedCategoryId;
          },
          builder: (context, state) {
            return Card(
              elevation: 2,
              shape: state.selectedCategoryId == selectedCategory.id
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
            );
          }),
    );
  }
}
