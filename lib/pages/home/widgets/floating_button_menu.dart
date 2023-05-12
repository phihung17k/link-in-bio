import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_state.dart';
import '../../../models/item_model.dart';
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
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                    backgroundColor: Colors.blueAccent.shade100,
                    title: Row(
                      children: [
                        Expanded(
                          child: BlocBuilder<HomeBloc, HomeState>(
                            bloc: bloc,
                            buildWhen: (previous, current) {
                              return previous.isSelectAll !=
                                  current.isSelectAll;
                            },
                            builder: (context, state) {
                              return CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: state.isSelectAll,
                                tileColor: Colors.transparent,
                                onChanged: (value) {
                                  if (value!) {
                                    bloc!.add(SelectingAllItemEvent());
                                  } else {
                                    bloc!.add(ResetSelectedItemsEvent());
                                  }
                                },
                                title: const Text("Select all"),
                              );
                            },
                          ),
                        ),
                        InkWell(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Text("Share",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!)),
                          onTap: () {
                            if (bloc!.state.selectedIndexList!.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No items selected"),
                                duration: Duration(seconds: 1),
                              ));
                            }
                            Navigator.pop(context, "share");
                          },
                        )
                      ],
                    )),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  ItemModel item = items![index];
                  return BlocBuilder<HomeBloc, HomeState>(
                    bloc: bloc,
                    buildWhen: (previous, current) {
                      return previous.selectedIndexList!.contains(index) !=
                          current.selectedIndexList!.contains(index);
                    },
                    builder: (context, state) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: state.selectedIndexList!.contains(index),
                        onChanged: (value) {
                          if (value!) {
                            bloc!.add(AddingSelectedItemEvent(index));
                          } else {
                            bloc!.add(DeletingSelectedItemEvent(index));
                          }
                        },
                        title: Text(item.name!),
                        subtitle: Text("Not set"),
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
          lastAnimatedHeight: 296,
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
            lastAnimatedHeight: 242,
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
          lastAnimatedHeight: 188,
          label: "Share",
          iconData: Icons.share_rounded,
          onTap: () {
            showSharingBottomSheet(context).then((value) {
              if (value == null) {
                bloc!.add(ResetSelectedItemsEvent());
              } else {
                if (bloc!.state.selectedIndexList!.isNotEmpty) {
                  bloc!.addNavigatedEvent(NavigatorQRSharingPageEvent());
                }
              }
            });
          },
        ),
        FloatingButton(
          key: UniqueKey(),
          floatingButtonController: floatingButtonController,
          expandAnimation: expandAnimation,
          lastAnimatedHeight: 134,
          label: "Scan QR",
          iconData: Icons.qr_code_scanner,
          onTap: () {
            bloc!.addNavigatedEvent(NavigatorScannerPageEvent());
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
