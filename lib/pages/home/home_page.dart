import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/app_icons.dart';
import 'package:link_in_bio/bloc/home/home_bloc.dart';
import 'package:link_in_bio/bloc/home/home_state.dart';
import 'package:link_in_bio/models/item_model.dart';
import 'package:link_in_bio/pages/home/widgets/bottom_bar_widget.dart';

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

  // bool isDragUpBottom = true;
  double itemRadius = 20;
  // Map<String, String> itemList = {};
  // List<ItemModel> items = [];
  // double deletedIconWidth = 0.0;

  AnimationController? deleteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deleteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

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
                    // mainAxisAlignment: MainAxisAlignment.center,
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
              BottomBarWidget(
                size: size,
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
    bloc.close();
    super.dispose();
  }
}
