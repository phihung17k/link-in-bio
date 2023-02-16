import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/pages/pages.dart';

class ItemInfoPage extends StatefulWidget {
  final ItemInfoBloc bloc;
  const ItemInfoPage(this.bloc, {super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  ItemInfoBloc get bloc => widget.bloc;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: BlocProvider.value(
          value: bloc,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                //controller: ,

                tabs: [
                  Tab(text: "Category", icon: Icon(Icons.category)),
                  Tab(text: "Test", icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
              title: const Text('Settings'),
              centerTitle: true,
            ),
            body: TabBarView(
              children: [
                ItemCategorySubPage(),
                ItemContentSubPage(),
                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        DefaultTabController.of(context)!.animateTo(0);
                      },
                      icon: Icon(Icons.directions_bike));
                }),
              ],
            ),
          ),
        ));
  }
}
