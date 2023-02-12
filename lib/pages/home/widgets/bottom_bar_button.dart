import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Function() onPressed;
  const BottomBarButton(
      {super.key,
      required this.label,
      required this.iconData,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(iconData),
        const SizedBox(
          width: 5,
        ),
        Text(label)
      ]),
    );
  }
}
