import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';

import '../../../app_icons.dart';
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
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              // isDismissible: true,
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              // ),
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.8,
                  expand: false,
                  builder: (context, scrollController) {
                    return Container(
                      color: Colors.amber,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 100,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(index.toString()),
                          onTap: () => Navigator.of(context).pop(index),
                        ),
                      ),
                    );
                  },
                );
              },
            );
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
