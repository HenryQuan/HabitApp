import 'Package:HabitApp/src/core/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Completed class
class Completed extends StatefulWidget {
  // Whether animation needs to be shown
  Completed({Key key, @required bool animated}) : super(key: key);

  @override
  _CompletedState createState() => _CompletedState();
}


class _CompletedState extends State<Completed> with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> containerHeight;
  Animation<double> containerWidth;
  Animation<double> containerRadius;

  Animation<double> iconSize;
  double textOpacity = 0;

  @override
  void initState() {
    super.initState();
    this.setupAnimation();
  }

  /// Setup animation if it is necessary
  void setupAnimation() {
    setState(() {
      textOpacity = 1;
    });
  }

  @override
  void dispose() {
    if (controller != null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = Utils.getBestWidth(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: AnimatedContainer(
        height: deviceSize.height,
        width: deviceSize.width,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.green[600],
          borderRadius: BorderRadius.circular(0),
        ),
        curve: Curves.easeIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check, size: deviceWidth / 2),
            AnimatedOpacity(
              child: Text('Come back tomorrow :)'),
              duration: Duration(milliseconds: 300),
              opacity: this.textOpacity,
            ),
          ],
        ),
      ),
      value: SystemUiOverlayStyle(
        // Match current screen colour
        statusBarBrightness: Brightness.light,
        // Android
        statusBarColor: Colors.green[900],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.green[600],
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }
}
