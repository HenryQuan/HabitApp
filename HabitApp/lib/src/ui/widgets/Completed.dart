import 'dart:async';

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
  double containerHeight;
  double containerWidth;
  BorderRadius containerRadius;

  double textOpacity = 0.0;
  double iconSize = 0.0;
  bool showIcon = false;

  bool showFirstMsg = true;

  @override
  void initState() {
    super.initState();
    if (widget.animated) {
      // Start from zero
      containerWidth = 0.0;
      containerHeight = 0.0;
      containerRadius = BorderRadius.circular(200.0);
    } else {
      // Already good
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update container
    Future.delayed(Duration.zero).then((_) {
      final deviceSize = MediaQuery.of(context).size;
      setState(() {
        containerWidth = deviceSize.width;
        containerHeight = deviceSize.height;
        containerRadius = BorderRadius.circular(0.0);
      });
    });

    // Show icon
    Future.delayed(Duration(milliseconds: 600)).then((_) {
      setState(() {
        showIcon = true;
      });
    });

    // Update theme to be dark only here
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: AnimatedContainer(
        height: containerHeight,
        width: containerWidth,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.green[600],
          borderRadius: containerRadius
        ),
        curve: Curves.linearToEaseOut,
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
      final deviceWidth = Utils.getBestWidth(context);
      // Update icon size
      Future.delayed(Duration.zero).then((_) {
        setState(() {
          iconSize = deviceWidth / 2;
        });
      });

      // Fade in text
      Future.delayed(Duration(seconds: 1)).then((_) {
        setState(() {
          textOpacity = 1.0;
        });
      });

      Future.delayed(Duration(milliseconds: 2200)).then((_) {
        setState(() {
          showFirstMsg = false;
        });
      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSize(
            duration: Duration(milliseconds: 300),
            vsync: this,
            child: Icon(
              Icons.check, 
              size: iconSize,
              color: Colors.white,
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: textOpacity,
            child: AnimatedCrossFade(
              firstCurve: Curves.elasticOut,
              secondCurve: Curves.elasticOut,
              duration: Duration(milliseconds: 200),
              firstChild: renderText('All good', deviceWidth),
              secondChild: renderText('Come back tomorrow :)', deviceWidth),
              crossFadeState: showFirstMsg ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            )
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Render a text widget with msg and preset styles
  Widget renderText(String msg, double width) {
    return Text(
      msg,
      style: TextStyle(fontSize: width / 20, color: Colors.white),
    );
  }
}
