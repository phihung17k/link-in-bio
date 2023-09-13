import 'dart:math';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            return ScaleTransition(
              scale: DelayTween(begin: 0.0, end: 1.0, delay: index * .2)
                  .animate(_controller!),
              child: const SizedBox.square(
                dimension: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class DelayTween extends Tween<double> {
  DelayTween({
    double? begin,
    double? end,
    required this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
