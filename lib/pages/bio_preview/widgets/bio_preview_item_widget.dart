import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../models/item_model.dart';

class BioPreviewItemWidget extends StatelessWidget {
  final double itemRadius = 20;
  final ItemModel? item;
  const BioPreviewItemWidget({super.key, required this.item});

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

  Future<void> _launchUrlV2(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await _launchUrl(context);
        //2384251218489340
        //109861992081824
        // String appUrl = "fb://page/109861992081824";
        // String appUrl = "fb://profile/100007134556052";
        String appUrl = "fb://page/109861992081824";
        String webUrl = 'https://www.facebook.com/phihung17k';

        if (await canLaunchUrlString(appUrl)) {
          await launchUrlString(appUrl);
        } else if (await canLaunchUrlString(webUrl)) {
          await launchUrlString(webUrl);
        } else {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Could not launch $appUrl or $webUrl"),
            duration: const Duration(seconds: 1),
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
