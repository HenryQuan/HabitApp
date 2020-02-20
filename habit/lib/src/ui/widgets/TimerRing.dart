import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class TimerRing extends CustomPainter {
  double _percentage;
  double getPercentage() => this._percentage;

  /// Ask for how many percent is done
  /// - percentage must be between `0 and 1`
  TimerRing({percentage: double}) {
    this._percentage = percentage;
  }

  @override
  /// From https://stackoverflow.com/questions/59917009/how-to-include-stroke-cap-in-sweep-gradient
  void paint(Canvas canvas, Size size) {
    double centerP = size.height / 2;
    // Why?
    Rect circle = Rect.fromCircle(center: Offset(centerP, centerP), radius: centerP);

    // Setup the painter
    Paint painter = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawArc(circle, this._degreeToRad(270), this._degreeToRad(360 * _percentage), false, painter);
  }

  /// Convert degree to rad
  double _degreeToRad(double degree) => degree * pi / 180;

  @override
  /// Only update if the percentage is different
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is TimerRing) {
      return oldDelegate.getPercentage() == this._percentage;
    }

    return false;
  }
}