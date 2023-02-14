import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/app_icons.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/pages/home/widgets/bottom_bar_widget.dart';
import 'package:link_in_bio/pages/home/widgets/floating_button.dart';

import '../../bloc/home/home_event.dart';
import '../../routes.dart';
import '../../utils/pop_with_results.dart';
import 'widgets/item_widget.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;
  const HomePage(this.bloc, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeBloc get bloc => widget.bloc;

  AnimationController? deleteController;

  AnimationController? floatingButtonController;
  Animation? expandAnimation;
  Animation? rotateAnimation;

  @override
  void initState() {
    super.initState();
    deleteController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    floatingButtonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    expandAnimation = Tween<double>(begin: 0, end: 60).animate(CurvedAnimation(
        parent: floatingButtonController!, curve: const Interval(0.7, 1)));

    rotateAnimation = Tween<double>(begin: 0, end: pi / 4).animate(
        CurvedAnimation(
            parent: floatingButtonController!, curve: const Interval(0, 0.4)));

    //for test
    bloc.add(AddingItemTestEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        backgroundColor: Colors.cyan.shade100,
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: bloc,
          builder: (context, state) {
            return Stack(children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/default_avatar.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Name",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Personal information"),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: state.itemList!.length,
                          itemBuilder: (context, index) {
                            return ItemWidget(
                              index: index,
                              item: state.itemList![index],
                              deleteController: deleteController,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height / 4,
                      ),
                    ],
                  )),
              // BottomBarWidget(
              //   size: size,
              //   deleteController: deleteController,
              // ),

              //multiple animations with
              // - Staggered Animations: order by time
              //    + ex: Total time is 1, animation 1 (0 - 0.5), animation 2(0.5 - 1)
              //    + using Interval
              // - Tween Chaining: using TweenSequence (for a animation)
              FloatingButton(
                floatingButtonController: floatingButtonController,
                expandAnimation: expandAnimation,
                lastAnimatedHeight: 188,
                label: "Create",
                iconData: Icons.add_circle_outline_outlined,
                onTap: () {
                  Navigator.pushNamed(context, Routes.itemCategoryChoosing)
                      .then((value) {
                    if (value is PopWithResults<ItemModel>) {
                      if (value.toPage == Routes.home) {
                        bloc.add(AddingItemEvent(value.result));
                      }
                    }
                  });
                },
              ),
              FloatingButton(
                  floatingButtonController: floatingButtonController,
                  expandAnimation: expandAnimation,
                  lastAnimatedHeight: 134,
                  label: "Remove",
                  iconData: Icons.remove_circle_outline_outlined,
                  onTap: () {
                    if (deleteController!.isDismissed) {
                      deleteController!.forward();
                    } else {
                      deleteController!.reverse();
                    }
                  }),
              FloatingButton(
                floatingButtonController: floatingButtonController,
                expandAnimation: expandAnimation,
                lastAnimatedHeight: 80,
                label: "Share",
                iconData: AppIcons.share,
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
                    child:
                        Icon(Icons.add, size: IconTheme.of(context).size! + 5),
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
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("dispose");
    deleteController!.dispose();
    floatingButtonController!.dispose();
    bloc.close();
    super.dispose();
  }
}
