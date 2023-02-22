import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/item_model.dart';

import '../../bloc/home/home_event.dart';
import '../../routes.dart';
import 'widgets/floating_button_menu.dart';
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

  @override
  void initState() {
    super.initState();
    deleteController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    //for test
    // bloc.add(AddingItemTestEvent());

    bloc.listenerStream.listen((event) {
      if (event is NavigatorItemInfoPageForCreatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo).then((item) {
          if (item is ItemModel) {
            bloc.add(AddingItemEvent(item));
          }
        });
      } else if (event is NavigatorItemInfoPageForUpdatingEvent) {
        Navigator.pushNamed(context, Routes.itemInfo, arguments: event.item)
            .then((value) {
          if (value is ItemModel) {
            bloc.add(UpdatingItemEvent(event.index, value));
          }
        });
      }
    });
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
              FloatingButtonMenu(
                key: UniqueKey(),
                deleteController: deleteController,
              )
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    deleteController!.dispose();
    bloc.close();
    super.dispose();
  }
}
