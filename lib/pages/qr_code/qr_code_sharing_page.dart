import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/qr_code/qr_code_bloc.dart';
import 'package:link_in_bio/pages/qr_code/widgets/qr_code_web.dart';
import 'package:link_in_bio/utils/network_connectivity.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../bloc/qr_code/qr_code_event.dart';
import '../../models/item_model.dart';

class QRCodeSharingPage extends StatefulWidget {
  final QRCodeBloc bloc;

  const QRCodeSharingPage(this.bloc, {super.key});

  @override
  State<QRCodeSharingPage> createState() => _QRCodeSharingPageState();
}

class _QRCodeSharingPageState extends State<QRCodeSharingPage> {
  QRCodeBloc get bloc => widget.bloc;

  final NetworkConnectivity _connectivity = NetworkConnectivity();

  @override
  void initState() {
    super.initState();

    _connectivity.initialize();
    _connectivity.connectionStream.listen((event) {
      bloc.add(SetInternetInfoEvent(event));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        // backgroundColor: Colors.cyan.shade100,
        appBar: AppBar(
          actions: [
            TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: Theme.of(context).textTheme.titleMedium),
                onPressed: () {},
                child: Text("Preview"))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          color: Colors.green,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: const [Tab(text: "App"), Tab(text: "Web")]),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Container(
                        color: Colors.amber,
                        width: 100,
                        height: 100,
                      ),
                      const QRCodeWebWidget()
                    ]),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivity.dispose();
    bloc.close();
    super.dispose();
  }
}
