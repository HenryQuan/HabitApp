import 'Package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/ui/widgets/ResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';

import 'package:wakelock/wakelock.dart';

/// TimerRing class
class TimerRing extends StatefulWidget {
  TimerRing({Key key}) : super(key: key);

  @override
  _TimerRingState createState() => _TimerRingState();
}

class _TimerRingState extends State<TimerRing> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> smoothPercentage;

  @override
  void initState() {
    super.initState();

    // Keep screen awake
    Wakelock.enable();
    this._setupTimerAnimation();
  }

  /// Setup animation for the one minue timer
  void _setupTimerAnimation() {
    // Setup controller for an ultra smooth one minute animation
    controller = AnimationController(duration: Duration(seconds: 2), vsync: this);
    smoothPercentage = Tween(begin: 60.0, end: 0.0).animate(controller)
    ..addListener(() {
      setState(() {
        // Update the tween value
      });        
    });

    controller.addStatusListener((status) async {
      // When it is done, vibrate
      if (status == AnimationStatus.completed) {
        // Vibrate device
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        }
      }
    });

    // Start animation
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // Get the width of the device
    final deviceWidth = Utils.getBestWidth(context);
    final time = smoothPercentage.value;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size.fromRadius(deviceWidth / 4),
            painter: TimerPainter(context: context, percentage: time / 60),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            // The time should be a fixed number
            time.toStringAsFixed(0),
            style: TextStyle(fontSize: deviceWidth / 6),
          ),
        ),
        this.renderComplete(time),
      ],
    );
  }

  // Render complete with fancy animation
  Widget renderComplete(double time) {
    if (time == 0) {
      return Align(
        // This does cover up the top two
        alignment: Alignment.center,
        child: ResultWidget(
          mode: ResultMode.completed, 
          deviceSize: MediaQuery.of(context).size, 
          animated: false
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    Wakelock.disable();
    controller.dispose();
    super.dispose();
  }
}


class TimerPainter extends CustomPainter {
  double _percentage;
  BuildContext _context;

  /// Ask for how many percent is done
  /// - percentage must be between `0 and 1`
  TimerPainter({context: BuildContext, percentage: double}) {
    this._percentage = percentage;
    this._context = context;
  }

  @override
  /// From https://stackoverflow.com/questions/59917009/how-to-include-stroke-cap-in-sweep-gradient
  void paint(Canvas canvas, Size size) {
    double centerP = size.height / 2;
    // Why?
    Rect circle = Rect.fromCircle(center: Offset(centerP, centerP), radius: centerP);

    // Setup the painter
    Paint painter = Paint()
      ..color = Utils.isDarkTheme(this._context) ? Colors.white : Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 10;

    // The moving arc
    canvas.drawArc(circle, this._degreeToRad(270), this._degreeToRad(360 * _percentage), false, painter);
    // The stationary arc
    painter.strokeWidth = 3;
    canvas.drawArc(circle, this._degreeToRad(270), this._degreeToRad(360), false, painter);
  }

  /// Convert degree to rad
  double _degreeToRad(double degree) => degree * pi / 180;

  @override
  /// Only update if the percentage is different
  bool shouldRepaint(TimerPainter oldDelegate) {
    return oldDelegate._percentage != this._percentage;
  }
}