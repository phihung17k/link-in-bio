import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/item_model.dart';

class BioPreviewItemWidget extends StatelessWidget {
  final double itemRadius = 20;
  final ItemModel? item;
  const BioPreviewItemWidget({super.key, required this.item});

  Future<void> _launchUrl(BuildContext context) async {
    String url = "${item!.category!.baseURL}${item!.url}";
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // ignore: use_build_context_synchronously
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Could not launch $uri"),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _launchUrl(context);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: itemRadius,
                backgroundImage: AssetImage(item!.category!.imageURL!),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(item!.name!, overflow: TextOverflow.ellipsis),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
