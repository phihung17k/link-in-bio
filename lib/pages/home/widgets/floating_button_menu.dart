import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/item_model.dart';

import '../../../bloc/home/home_event.dart';
import 'floating_button.dart';

class FloatingButtonMenu extends StatefulWidget {
  final AnimationController? deleteController;
  const FloatingButtonMenu({super.key, required this.deleteController});

  @override
  State<FloatingButtonMenu> createState() => _FloatingButtonMenuState();
}

class _FloatingButtonMenuState extends State<FloatingButtonMenu>
    with TickerProviderStateMixin {
  HomeBloc? bloc;

  AnimationController? floatingButtonController;
  Animation? expandAnimation;
  Animation? rotateAnimation;

  AnimationController get deleteController => widget.deleteController!;

  @override
  void initState() {
    super.initState();

    floatingButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    expandAnimation = Tween<double>(begin: 0, end: 60).animate(CurvedAnimation(
        parent: floatingButtonController!, curve: const Interval(0.7, 1)));

    rotateAnimation = Tween<double>(begin: 0, end: pi / 4).animate(
        CurvedAnimation(
            parent: floatingButtonController!, curve: const Interval(0, 0.4)));

    bloc = context.read<HomeBloc>();
  }

  Future showSharingBottomSheet(BuildContext context) {
    List<ItemModel>? items = bloc?.state.itemList;
    List<ItemModel>? selectedItems = bloc?.state.selectedItemList;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // isDismissible: true,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      // ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.4,
          maxChildSize: 0.7,
          expand: false,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    titleSpacing: 0,
                    pinned: true,
                    title: Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: false,
                            onChanged: (value) {},
                            title: const Text("Select all"),
                          ),
                        ),
                      ],
                    )),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  ItemModel item = items![index];
                  // print("bool ${selectedItems!.contains(item)}");
                  return BlocBuilder<HomeBloc, HomeState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: state.selectedItemList!.contains(item),
                        onChanged: (value) {
                          // print(
                          //     "value $value and ${state.selectedItemList!.length}");
                          if (value!) {
                            bloc!.add(AddingSelectedItemEvent(item));
                          } else {
                            bloc!.add(DeletingSelectedItemEvent(item));
                          }
                        },
                        title: Text(item.name!),
                        subtitle:
                            Text(item.url!.isEmpty ? "Not set" : item.url!),
                      );
                    },
                  );
                }, childCount: items?.length))
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //multiple animations with
        // - Staggered Animations: order by time
        //    + ex: Total time is 1, animation 1 (0 - 0.5), animation 2(0.5 - 1)
        //    + using Interval
        // - Tween Chaining: using TweenSequence (for a animation)
        FloatingButton(
          key: UniqueKey(),
          floatingButtonController: floatingButtonController,
          expandAnimation: expandAnimation,
          lastAnimatedHeight: 242,
          label: "Create",
          iconData: Icons.add_circle_outline_outlined,
          onTap: () {
            bloc!.addNavigatedEvent(NavigatorItemInfoPageForCreatingEvent());
          },
        ),
        FloatingButton(
            key: UniqueKey(),
            floatingButtonController: floatingButtonController,
            expandAnimation: expandAnimation,
            lastAnimatedHeight: 188,
            label: "Remove",
            iconData: Icons.remove_circle_outline_outlined,
            onTap: () {
              deleteController.isDismissed
                  ? deleteController.forward()
                  : deleteController.reverse();
            }),
        FloatingButton(
          key: UniqueKey(),
          floatingButtonController: floatingButtonController,
          expandAnimation: expandAnimation,
          lastAnimatedHeight: 134,
          label: "Share",
          iconData: Icons.share_rounded,
          onTap: () {
            showSharingBottomSheet(context).whenComplete(() {
              print("end");
            });
            // bloc!.addNavigatedEvent(NavigatorQRSharingPageEvent());
          },
        ),
        FloatingButton(
          key: UniqueKey(),
          floatingButtonController: floatingButtonController,
          expandAnimation: expandAnimation,
          lastAnimatedHeight: 80,
          label: "Settings",
          iconData: Icons.settings,
          onTap: () {},
        ),
        Positioned(
          right: 15,
          bottom: 15,
          child: FloatingActionButton(
            onPressed: () {
              floatingButtonController!.isDismissed
                  ? floatingButtonController!.forward()
                  : floatingButtonController!.reverse();
            },
            child: AnimatedBuilder(
              animation: floatingButtonController!,
              child: Icon(Icons.add, size: IconTheme.of(context).size! + 5),
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotateAnimation!.value,
                  alignment: Alignment.center,
                  child: child,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    floatingButtonController!.dispose();
    super.dispose();
  }
}
