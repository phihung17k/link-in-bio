import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/home/home_event.dart';
import '../../../bloc/home/home_state.dart';
import 'item_animated_builder.dart';
import 'item_widget.dart';

class ReorderListWidget extends StatelessWidget {
  final AnimationController? deleteController;

  const ReorderListWidget(this.deleteController, {super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          return ReorderableListView.builder(
            padding: const EdgeInsets.all(8),
            onReorder: (oldIndex, newIndex) {
              // bug of newIndex in ReorderableListView
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              bloc.add(
                  ReorderItemEvent(oldIndex: oldIndex, newIndex: newIndex));
            },
            itemCount: state.itemList?.length ?? 0,
            itemBuilder: (context, index) {
              var item = state.itemList?[index];
              return ItemWidget(
                key: ValueKey(item),
                item: item,
                deleteController: deleteController,
              );
            },
            proxyDecorator: (child, index, animation) {
              return ItemAnimatedBuilder(
                key: ValueKey(child),
                animation: animation,
                child: child,
              );
            },
          );
        });
  }
}
