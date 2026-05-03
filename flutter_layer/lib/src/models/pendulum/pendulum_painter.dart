import 'dart:math';
import 'package:flutter/material.dart';

class PendulumPainter extends CustomPainter {
  final double theta;
  final double lengthMeters;

  // Коэффициент перевода: 1 метр физики = 100 пикселей на экране
  final double scale = 100.0;

  PendulumPainter({required this.theta, required this.lengthMeters});

  @override
  void paint(Canvas canvas, Size size) {
    final pivot = Offset(size.width / 2, 50); // Точка крепления

    // Длина в пикселях
    final lengthPx = lengthMeters * scale;

    // Вычисляем координаты груза (математика + поворот осей для экрана)
    final bobX = pivot.dx + lengthPx * sin(theta);
    final bobY = pivot.dy + lengthPx * cos(theta);
    final bob = Offset(bobX, bobY);

    // Настройки кистей
    final threadPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 2;

    final bobPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    // Рисуем
    canvas.drawLine(pivot, bob, threadPaint);
    canvas.drawCircle(bob, 20, bobPaint);
  }

  @override
  bool shouldRepaint(covariant PendulumPainter oldDelegate) {
    return oldDelegate.theta != theta ||
        oldDelegate.lengthMeters != lengthMeters;
  }
}
