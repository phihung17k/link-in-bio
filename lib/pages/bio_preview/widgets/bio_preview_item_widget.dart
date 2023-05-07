import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/item_model.dart';
import '../../../models/data_model.dart';

class BioPreviewItemWidget extends StatelessWidget {
  final double itemRadius = 20;
  final ItemModel item;
  const BioPreviewItemWidget(this.item, {super.key});

  // Future<void> _launchUrl(BuildContext context) async {
  //   String url = "${item!.category!.baseURL}${item!.url}";
  //   Uri uri = Uri.parse(url);

  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     if (!context.mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text("Could not launch $uri"),
  //       duration: const Duration(seconds: 1),
  //     ));
  //   }
  // }

  /// Example:
  /// ```dart
  /// final httpsUri = Uri(
  ///     scheme: 'https',
  ///     host: 'dart.dev',
  ///     path: 'guides/libraries/library-tour',
  ///     fragment: 'numbers');
  /// print(httpsUri); // https://dart.dev/guides/libraries/library-tour#numbers
  ///
  /// final mailtoUri = Uri(
  ///     scheme: 'mailto',
  ///     path: 'John.Doe@example.com',
  ///     queryParameters: {'subject': 'Example'});
  /// print(mailtoUri); // mailto:John.Doe@example.com?subject=Example
  /// ```

  Uri? getUri() {
    Uri? result;
    switch (item.category?.name?.toLowerCase()) {
      case "sms":
        SmsModel sms = item.sms as SmsModel;
        result = Uri.tryParse("sms:${sms.phoneNumber}?body=${sms.message}");
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // String appUrl = "fb://page/109861992081824";
        // String appUrl = "fb://profile/100007134556052";
        // String webUrl = 'https://www.facebook.com/phihung17k';
        // String appUrl = getAppURL();

        Uri? uri = getUri();
        bool isLaunchUrl = true;
        if (uri == null) {
          isLaunchUrl = false;
        } else {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
          // else if (await canLaunchUrlString(appUrl)) {
          //   await launchUrlString(appUrl);
          // } else if (await canLaunchUrlString(webUrl)) {
          //   await launchUrlString(webUrl, mode: LaunchMode.externalApplication);
          // }
          else {
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
