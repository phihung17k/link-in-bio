import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';

import '../../../bloc/home/home_event.dart';
import '../../../models/item_model.dart';
import '../../../routes.dart';
import '../../../utils/pop_with_results.dart';

class ItemWidget extends StatelessWidget {
  final int? index;
  final ItemModel? item;
  final double itemRadius = 20;
  final AnimationController? deleteController;
  const ItemWidget(
      {super.key,
      required this.item,
      required this.index,
      required this.deleteController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.itemInfo, arguments: item)
            .then((value) {
          if (value is PopWithResults<ItemModel>) {
            context
                .read<HomeBloc>()
                .add(UpdatingItemEvent(index!, value.result));
          }
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: itemRadius,
                backgroundImage: AssetImage(item!.symbolPath!),
              ),
              Text("${item!.name!}, ${item!.url}"),
              SizeTransition(
                sizeFactor:
                    Tween<double>(begin: 0, end: 1).animate(deleteController!),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_rounded,
                  ),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
