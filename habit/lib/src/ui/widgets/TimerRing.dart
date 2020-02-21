import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

/// TimerRing class
class TimerRing extends StatefulWidget {
  TimerRing({Key key}) : super(key: key);

  @override
  _TimerRingState createState() => _TimerRingState();
}

class _TimerRingState extends State<TimerRing> {
  int time = 60;

  @override
  void initState() {
    super.initState();
    
    // Update timer every second
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(timer);
      setState(() {
        time = time == 0 ? 60 : time - 1;
      });
    });
  }

  /// Always return the short side
  double _getBestWidth() {
    final size = MediaQuery.of(context).size;
    return size.height < size.width ? size.height : size.width;
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the device
    final deviceWidth = this._getBestWidth();

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size.fromRadius(deviceWidth / 4),
            painter: TimerPainter(percentage: time / 60),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            time.toString(),
            style: TextStyle(fontSize: deviceWidth / 6),
          ),
        )
      ],
    );
  }
}


class TimerPainter extends CustomPainter {
  double _percentage;

  /// Ask for how many percent is done
  /// - percentage must be between `0 and 1`
  TimerPainter({percentage: double}) {
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
    if (oldDelegate is TimerPainter) {
      return oldDelegate._percentage == this._percentage;
    }

    return false;
  }
}