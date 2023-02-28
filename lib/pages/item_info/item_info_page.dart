import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/pages/pages.dart';

import '../../bloc/item_info/item_info_event.dart';
import '../../models/item_model.dart';

class ItemInfoPage extends StatefulWidget {
  final ItemInfoBloc bloc;
  const ItemInfoPage(this.bloc, {super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  ItemInfoBloc get bloc => widget.bloc;

  @override
  void initState() {
    super.initState();
    bloc.add(InitialDataEvent());

    bloc.listenerStream.listen((event) {
      if (event is BackingHomePageEvent) {
        ItemModel item = bloc.state.item!;
        if (item.name == null || item.name!.trim().isEmpty) {
          item = item.copyWith(name: item.category!.name);
        }
        Navigator.pop(context, item);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is ItemModel) {
      ItemModel item = setting.arguments as ItemModel;
      bloc.add(UpdatingCurrentItemEvent(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: BlocProvider.value(
          value: bloc,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(text: "Category", icon: Icon(Icons.category)),
                Tab(text: "Detail", icon: Icon(Icons.directions_transit))
              ]),
              title: const Text('Settings'),
              centerTitle: true,
            ),
            body: const TabBarView(
              children: [ItemCategorySubPage(), ItemContentSubPage()],
            ),
          ),
        ));
  }
}
