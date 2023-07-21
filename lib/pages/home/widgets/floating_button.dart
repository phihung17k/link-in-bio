import 'package:flutter/material.dart';

class FloatingButton extends StatefulWidget {
  final AnimationController? floatingButtonController;
  final double? lastAnimatedHeight;
  final String? label;
  final IconData? iconData;
  final Function()? onTap;
  final Color? color;
  final double? widthScreen;
  const FloatingButton(
      {super.key,
      required this.floatingButtonController,
      required this.lastAnimatedHeight,
      required this.label,
      this.iconData = Icons.question_mark_rounded,
      this.onTap,
      this.color = Colors.amber,
      this.widthScreen});

  @override
  State<FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  AnimationController get floatingButtonController =>
      widget.floatingButtonController!;
  double get lastAnimatedHeight => widget.lastAnimatedHeight!;
  String get label => widget.label!;
  IconData get iconData => widget.iconData!;
  Function() get onTap => widget.onTap!;
  Color get color => widget.color!;
  Animation? translateAnimation;
  Animation? expandAnimation;

  @override
  void initState() {
    super.initState();
    // 19 is the middle height of floating action button (bottom 15 + half of FBA (28 - 19))
    // height of FAB is 56
    translateAnimation = Tween<double>(begin: 19, end: lastAnimatedHeight)
        .animate(CurvedAnimation(
            parent: floatingButtonController, curve: const Interval(0, 0.7)));

    expandAnimation = Tween<double>(begin: 0, end: widget.widthScreen! / 6)
        .animate(CurvedAnimation(
            parent: floatingButtonController, curve: const Interval(0.7, 1)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatingButtonController,
      builder: (context, child) {
        return Positioned(
          right: 18,
          bottom: translateAnimation!.value,
          child: Visibility(
            visible: floatingButtonController.isDismissed ? false : true,
            child: InkWell(
              onTap: onTap,
              child: Material(
                elevation: 2,
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(iconData),
                      SizedBox(
                        width: expandAnimation?.value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(label,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
