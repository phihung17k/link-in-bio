import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_event.dart';
import '../../../models/item_model.dart';

class ItemWidget extends StatelessWidget {
  final double itemRadius = 20;
  final int? index;
  final ItemModel? item;
  final AnimationController? deleteController;
  const ItemWidget(
      {super.key,
      required this.item,
      required this.index,
      required this.deleteController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<HomeBloc>().addNavigatedEvent(
              NavigatorItemInfoPageForUpdatingEvent(index!, item!));
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Theme.of(context).colorScheme.tertiary,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: itemRadius,
                  backgroundImage: AssetImage(item!.category!.image!),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(item!.name!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                SizeTransition(
                  sizeFactor: Tween<double>(begin: 0, end: 1)
                      .animate(deleteController!),
                  child: IconButton(
                    onPressed: () {
                      HomeBloc bloc = context.read<HomeBloc>();
                      // if (bloc.state.itemList?.length == 1 &&
                      //     deleteController!.isCompleted) {
                      // deleteController!.reverse();
                      // }
                      bloc.add(DeletingItemEvent(item!.id!));
                    },
                    padding: const EdgeInsets.only(right: 5),
                    constraints:
                        const BoxConstraints(minHeight: 10, maxHeight: 24),
                    icon: const Icon(
                      Icons.delete_rounded,
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
