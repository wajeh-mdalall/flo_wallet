import 'package:flutter/material.dart';

class ScannerBorderPainter extends CustomPainter {
  ScannerBorderPainter({super.repaint,});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF3C69C9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final double cornerSize = 30;
    final path = Path();
    //(Top Left)
    drawCorner(
      path: path,
      startPoint: Offset(0, cornerSize),
      cornerPoint: const Offset(0, 0),
      endPoint: Offset(cornerSize, 0),
    );

    //(Top Right)
    drawCorner(
      path: path,
      startPoint: Offset(size.width - cornerSize, 0),
      cornerPoint: Offset(size.width, 0),
      endPoint: Offset(size.width, cornerSize),
    );

    //(Bottom Right)
    drawCorner(
      path: path,
      startPoint: Offset(size.width, size.height - cornerSize),
      cornerPoint: Offset(size.width, size.height),
      endPoint: Offset(size.width - cornerSize, size.height),
    );

    //(Bottom Left)
    drawCorner(
      path: path,
      startPoint: Offset(cornerSize, size.height),
      cornerPoint: Offset(0, size.height),
      endPoint: Offset(0, size.height - cornerSize),
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
  void drawCorner({
    required Path path,
    required Offset startPoint,
    required Offset cornerPoint,
    required Offset endPoint,
  }) {
    path.moveTo(startPoint.dx, startPoint.dy);
    path.lineTo(cornerPoint.dx, cornerPoint.dy);
    path.lineTo(endPoint.dx, endPoint.dy);
  }
}
