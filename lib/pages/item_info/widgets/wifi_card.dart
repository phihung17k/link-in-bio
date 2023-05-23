import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_bloc.dart';
import 'package:link_in_bio/bloc/item_info/item_info_event.dart';
import 'package:link_in_bio/bloc/item_info/item_info_state.dart';

class WifiCard extends StatelessWidget {
  final TextEditingController? networkNameController;
  final TextEditingController? passwordController;

  WifiCard({super.key, this.networkNameController, this.passwordController});

  final List<String> encryptions = ['None', 'WPA/WPA2', 'WEP'];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WiFi", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: networkNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Network Name"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                    controller: passwordController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password"),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Encryption:",
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: BlocBuilder<ItemInfoBloc, ItemInfoState>(
                        bloc: context.read<ItemInfoBloc>(),
                        builder: (context, state) {
                          return DropdownButton(
                            value: state.networkEncryption ?? encryptions.first,
                            underline: const SizedBox(),
                            alignment: Alignment.center,
                            onChanged: (value) {
                              if (value != null) {
                                context
                                    .read<ItemInfoBloc>()
                                    .add(SetNetworkEncryptionEvent(value));
                              }
                            },
                            items: encryptions.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ])),
    );
  }
}
