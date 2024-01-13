import 'package:flutter/material.dart';

class BottomLivePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rectShape = Path()
      ..addRect(
          Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    final paint = Paint()..color = Colors.white;
    final arcShape = Path()
      ..moveTo(size.width - 96.5, 0)
      ..arcTo(Rect.fromCircle(center: Offset(size.width - 57.5, 0), radius: 41),
          0, 3.14, false)
      ..close();

    final combinedPath =
        Path.combine(PathOperation.difference, rectShape, arcShape);

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
