import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: ScannerOverlayPainter(),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.45);

    final cornerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    const frameWidth = 280.0;
    const frameHeight = 360.0;

    final left = (size.width - frameWidth) / 2;
    final top = (size.height - frameHeight) / 2;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        left,
        top,
        frameWidth,
        frameHeight,
      ),
      const Radius.circular(28),
    );

    // ==========================
    // Background Gelap
    // ==========================

    final background = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final hole = Path()..addRRect(rect);

    final overlay = Path.combine(
      PathOperation.difference,
      background,
      hole,
    );

    canvas.drawPath(
      overlay,
      overlayPaint,
    );

    // ==========================
    // Border Hijau
    // ==========================

    const c = 28.0;

    // ==========================
    // Top Left
    // ==========================

    canvas.drawLine(
      Offset(left, top + c),
      Offset(left, top),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(left, top),
      Offset(left + c, top),
      cornerPaint,
    );

    // ==========================
    // Top Right
    // ==========================

    canvas.drawLine(
      Offset(left + frameWidth - c, top),
      Offset(left + frameWidth, top),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(left + frameWidth, top),
      Offset(left + frameWidth, top + c),
      cornerPaint,
    );

    // ==========================
    // Bottom Left
    // ==========================

    canvas.drawLine(
      Offset(left, top + frameHeight - c),
      Offset(left, top + frameHeight),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(left, top + frameHeight),
      Offset(left + c, top + frameHeight),
      cornerPaint,
    );

    // ==========================
    // Bottom Right
    // ==========================

    canvas.drawLine(
      Offset(left + frameWidth - c, top + frameHeight),
      Offset(left + frameWidth, top + frameHeight),
      cornerPaint,
    );

    canvas.drawLine(
      Offset(left + frameWidth, top + frameHeight - c),
      Offset(left + frameWidth, top + frameHeight),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}