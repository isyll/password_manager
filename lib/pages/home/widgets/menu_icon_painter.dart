import 'package:flutter/material.dart';

class MenuIconPainter extends CustomPainter {
  final Color color;
  const MenuIconPainter({this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height / 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double spacing = size.height / 3;
    const double lineWidth = 16;
    const double middleLineWidth = 12;

    canvas.drawLine(
      Offset(0, 0),
      Offset(lineWidth, 0),
      paint,
    );

    canvas.drawLine(
      Offset(0, spacing),
      Offset(middleLineWidth, spacing),
      paint,
    );

    canvas.drawLine(
      Offset(0, 2 * spacing),
      Offset(lineWidth, 2 * spacing),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
