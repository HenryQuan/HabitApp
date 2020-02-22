import 'Package:HabitApp/src/core/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Completed class
class Completed extends StatefulWidget {
  final bool animated;

  // Whether animation needs to be shown
  Completed({Key key, @required this.animated}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}


class _CompletedState extends State<Completed> with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> containerHeight;
  Animation<double> containerWidth;
  Animation<BorderRadius> containerRadius;

  Animation<double> iconSize;
  double textOpacity = 0.0;
  bool showIcon = false;

  @override
  void initState() {
    super.initState();
    this.setupAnimation();
  }

  /// Setup animation if it is necessary
  void setupAnimation() {
    if (widget.animated) {
      controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);

      containerHeight = Tween(begin: 0.0, end: 1000.0).animate(controller)
      ..addListener(() {
        setState(() {
          // Update the tween value
        });        
      });

      containerWidth = Tween(begin: 0.0, end: 1000.0).animate(controller)
      ..addListener(() {
        setState(() {
          // Update the tween value
        });        
      });

      containerRadius = BorderRadiusTween(begin: BorderRadius.circular(200), end: BorderRadius.circular(0)).animate(controller)
      ..addListener(() {
        setState(() {
          // Update the tween value
        });        
      });

      controller.addStatusListener((status) async {
        // When it is done, toggle opacity animation
        if (status == AnimationStatus.completed) {
          // Vibrate device
          if (await Vibration.hasVibrator()) {
            Vibration.vibrate();
          }

          Future.delayed(Duration(seconds: 1)).then((value) {
            setState(() {
              showIcon = true;
            });
          });
        }
      });

      controller.forward();
    } else {
      // Only show the text animation
      setState(() {
        showIcon = true;
      });
    }
  }

  @override
  void dispose() {
    if (controller != null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update theme to be dark only here
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: AnimatedContainer(
        height: containerHeight.value,
        width: containerWidth.value,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.green[600],
          borderRadius: containerRadius.value
        ),
        curve: Curves.easeIn,
        child: this.renderIcon(),
      ),
      value: SystemUiOverlayStyle(
        // IOS, match current screen colour
        statusBarBrightness: Brightness.dark,
        // Android
        statusBarColor: Colors.green[900],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.green[900],
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  Widget renderIcon() {
    if (this.showIcon) {
      Future.delayed(Duration(seconds: 1)).then((_) {
        setState(() {
          textOpacity = 1.0;
        });
      });

      final deviceWidth = Utils.getBestWidth(context);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.check, 
            size: deviceWidth / 2,
            color: Colors.white,
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: textOpacity,
            child: Text(
              'Come back tomorrow :)',
              style: TextStyle(fontSize: deviceWidth / 20, color: Colors.white),
            ),
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
