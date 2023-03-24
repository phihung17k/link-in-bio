import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/bio_preview/bio_preview_bloc.dart';
import '../../bloc/bio_preview/bio_preview_event.dart';
import '../../bloc/bio_preview/bio_preview_state.dart';
import '../../pages/bio_preview/widgets/bio_preview_item_widget.dart';
import '../../models/item_model.dart';

class BioPreviewPage extends StatefulWidget {
  final BioPreviewBloc bloc;
  const BioPreviewPage(this.bloc, {super.key});

  @override
  State<BioPreviewPage> createState() => _BioPreviewPageState();
}

class _BioPreviewPageState extends State<BioPreviewPage> {
  BioPreviewBloc get bloc => widget.bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteSettings setting = ModalRoute.of(context)!.settings;
    if (setting.arguments != null && setting.arguments is List<ItemModel>) {
      List<ItemModel> items = setting.arguments as List<ItemModel>;
      bloc.add(LoadingBioDataEvent(items));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan.shade100,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Personal information"),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<BioPreviewBloc, BioPreviewState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state.items!.isNotEmpty) {
                        for (ItemModel item in state.items!) {
                          return BioPreviewItemWidget(
                            item: item,
                          );
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
