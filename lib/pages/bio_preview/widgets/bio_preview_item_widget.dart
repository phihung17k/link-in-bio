import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/item_model.dart';
import '../../../utils/link_util.dart';

class BioPreviewItemWidget extends StatelessWidget {
  final double itemRadius = 20;
  final ItemModel item;
  const BioPreviewItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // String appUrl = "fb://page/109861992081824";
        // String appUrl = "fb://profile/100007134556052";
        // String webUrl = 'https://www.facebook.com/phihung17k';
        // String appUrl = getAppURL();
        //"tel:0365162027"

        Uri? uri = LinkUtil.getUri(item);
        bool isLaunchUrl = true;
        if (uri == null) {
          isLaunchUrl = false;
        } else {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            isLaunchUrl = false;
          }
        }

        if (!isLaunchUrl) {
          // ignore: use_build_context_synchronously
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Could not launch url"),
            duration: Duration(seconds: 1),
          ));
        }
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
                backgroundImage: AssetImage(item.category!.image!),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text(item.name!, overflow: TextOverflow.ellipsis),
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
