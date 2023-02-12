import 'dart:ui';

import 'package:flutter/material.dart';

class DragBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, height);
    Offset p1l = Offset(width / 3, height);
    Offset p2l = Offset(width / 8, height / 6);
    Offset p3 = Offset(width / 2, 2);
    path.cubicTo(p1l.dx, p1l.dy, p2l.dx, p2l.dy, p3.dx, p3.dy);

    Offset p1r = Offset(width - width / 3, height);
    Offset p2r = Offset(width - width / 8, height / 6);
    Offset p4 = Offset(width, height);
    path.cubicTo(p2r.dx, p2r.dy, p1r.dx, p1r.dy, p4.dx, p4.dy);

    canvas.drawPath(path, paint);

    // List<Offset> list = [p1l, p2l, p1r, p2r];
    // Paint paint2 = Paint()
    //   ..color = Colors.pink
    //   ..strokeWidth = 5
    //   ..strokeCap = StrokeCap.round;
    // canvas.drawPoints(PointMode.points, list, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
