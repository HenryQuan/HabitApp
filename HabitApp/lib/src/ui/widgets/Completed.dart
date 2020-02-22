import 'Package:HabitApp/src/core/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Animation<double> containerRadius;

  Animation<double> iconSize;
  double textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    this.setupAnimation();
  }

  /// Setup animation if it is necessary
  void setupAnimation() {
    if (widget.animated) {
      controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    } else {
      // Only show the text animation
      setState(() {
        textOpacity = 1.0;
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
    final deviceSize = MediaQuery.of(context).size;
    final deviceWidth = Utils.getBestWidth(context);

    // Update theme to be dark only here
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        child: Scaffold(
          body: Center(
            child: AnimatedContainer(
              height: deviceSize.height,
              width: deviceSize.width,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.green[600],
                borderRadius: BorderRadius.circular(0)
              ),
              curve: Curves.easeIn,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.check, size: deviceWidth / 2),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: textOpacity,
                    child: Text('Come back tomorrow :)', style: TextStyle(fontSize: deviceWidth / 20)),
                  ),
                ],
              ),
            ),
          ),
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
      ),
    );
  }
}
