import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/pages/home/widgets/bottom_bar_button.dart';

import '../../../app_icons.dart';
import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_event.dart';
import '../../../models/item_model.dart';
import '../../../routes.dart';
import '../../../utils/pop_with_results.dart';

class BottomBarWidget extends StatefulWidget {
  final Size? size;
  final AnimationController? deleteController;

  const BottomBarWidget(
      {super.key, required this.size, required this.deleteController});

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  HomeBloc? bloc;
  Size get size => widget.size!;
  AnimationController get deleteController => widget.deleteController!;

  @override
  void initState() {
    super.initState();

    bloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500),
      bottom: bloc!.state.isDragUpBottom! ? 0 : -(80 / 1.5),
      child: GestureDetector(
          onVerticalDragUpdate: (details) {
            bloc!.add(UpdatingBottomStatusEvent(
                details.primaryDelta! > 0 ? false : true));
          },
          onTap: () {
            bloc!.add(UpdatingBottomStatusEvent(!bloc!.state.isDragUpBottom!));
          },
          child: Container(
            width: size.width,
            height: 80,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Icon(
                      bloc!.state.isDragUpBottom!
                          ? Icons.expand_more_outlined
                          : Icons.expand_less_outlined,
                      size: 30,
                      color: Colors.grey,
                    )),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomBarButton(
                          label: "Create",
                          iconData: Icons.add_circle_outline_outlined,
                          onPressed: () {
                            Navigator.pushNamed(
                                    context, Routes.itemCategoryChoosing)
                                .then((value) {
                              if (value is PopWithResults<ItemModel>) {
                                if (value.toPage == Routes.home) {
                                  bloc!.add(AddingItemEvent(value.result));
                                }
                              }
                            });
                          }),
                      BottomBarButton(
                          label: "Remove",
                          iconData: Icons.remove_circle_outline_outlined,
                          onPressed: () {
                            if (deleteController!.isDismissed) {
                              deleteController!.forward();
                            } else {
                              deleteController!.reverse();
                            }
                          }),
                      BottomBarButton(
                          label: "Share",
                          iconData: AppIcons.share,
                          onPressed: () {}),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
