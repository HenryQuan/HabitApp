import 'dart:async';

import 'Package:HabitApp/src/core/Utils.dart';
import 'package:HabitApp/src/core/LocalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

/// There are two modes for this wiget
enum ResultMode {
  /// Completed for today
  completed,
  /// The habit ends today
  ended,
  /// Didn't do it yesterday
  failed,
}

/// ResultWidget class
class ResultWidget extends StatefulWidget {
  final bool animated;
  final ResultMode mode;
  final Size deviceSize;

  // Whether animation needs to be shown
  ResultWidget({Key key, @required this.mode, @required this.deviceSize, @required this.animated}) : super(key: key);

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}


class _ResultWidgetState extends State<ResultWidget> with TickerProviderStateMixin {
  double containerHeight;
  double containerWidth;
  BorderRadius containerRadius;

  double textOpacity = 0.0;
  double iconSize = 0.0;
  bool showIcon = false;

  bool showFirstMsg = true;
  double shareOpacity = 0.0;

  double deviceWidth;
  ResultMode mode;

  @override
  void initState() {
    super.initState();

    this.mode = widget.mode;
  
    final size = widget.deviceSize;
    deviceWidth = size.height > size.width ? size.width : size.height;

    if (widget.animated) {
      // Start from zero
      containerWidth = 0.0;
      containerHeight = 0.0;
      containerRadius = BorderRadius.circular(200.0);
    } else {
      // Already good
      containerWidth = widget.deviceSize.width;
      containerHeight = widget.deviceSize.height;
      containerRadius = BorderRadius.circular(0.0);
      textOpacity = 1.0;
      showIcon = true;
      iconSize = deviceWidth / 2;
      showFirstMsg = false;
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

    Color backgroundColor, androidColor;
    // Get correct colour base on mode
    switch (mode) {
      case ResultMode.completed:
        backgroundColor = Colors.green[600];
        androidColor = Colors.green[900];
        break;
      case ResultMode.ended:
        backgroundColor = Colors.blue[500];
        androidColor = Colors.blue[900];
        break;
      case ResultMode.failed:
        backgroundColor = Colors.red[700];
        androidColor = Colors.red[900];
        break;
    }


    // Update theme to be dark only here
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: AnimatedContainer(
        height: containerHeight,
        width: containerWidth,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: containerRadius
        ),
        curve: Curves.linearToEaseOut,
        child: this.renderIcon(),
      ),
      value: SystemUiOverlayStyle(
        // IOS, match current screen colour
        statusBarBrightness: Brightness.dark,
        // Android
        statusBarColor: androidColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: androidColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  Widget renderIcon() {
    if (this.showIcon) {
      final deviceWidth = Utils.getBestWidth(context);
      final completed = widget.mode != ResultMode.failed;
  
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

      Future.delayed(Duration(milliseconds: 3500)).then((_) {
        setState(() {
          shareOpacity = 1.0;
        });
      });

      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  vsync: this,
                  child: this.renderIconWidget(mode),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: textOpacity,
                  child: this.renderAccordingMode(mode),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: this.renderShare(mode)
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Render the correct icon depending on whether user completes or fails
  Widget renderIconWidget(ResultMode mode) {
    IconData icon;
    switch (mode) {
      case ResultMode.completed:
        icon = Icons.check;
        break;
      case ResultMode.ended:
        icon = Icons.thumb_up;
        break;
      case ResultMode.failed:
        icon = Icons.close;
        break;
    }

    return Icon(
      icon, 
      size: iconSize,
      color: Colors.white,
    );
  }

  /// Only render share button if completed
  Widget renderShare(ResultMode mode) {
    if (mode != ResultMode.failed) {
      return AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: shareOpacity,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SizedBox(
            width: double.infinity,
            child: FlatButton.icon(
              onPressed: () {
                if (shareOpacity >= 0.9) {
                  Share.share('Hello World');
                }
              }, 
              icon: Icon(Icons.share, color: Colors.white), 
              label: Text('Share with friends', style: TextStyle(color: Colors.white))
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Render cross fade text or just fade in a button
  Widget renderAccordingMode(ResultMode mode) {
    if (mode != ResultMode.failed) {
      String first, second;

      // TODO: need some adjustment here
      if (mode == ResultMode.completed) {
        first = 'All good';
        second = 'See you tomorrow :)';
      } else {
        first = 'Amazing';
        second = 'You did it :)';
      }

      return AnimatedCrossFade(
        firstCurve: Curves.elasticOut,
        secondCurve: Curves.elasticOut,
        duration: Duration(milliseconds: 200),
        firstChild: renderText(first, deviceWidth),
        secondChild: renderText(second, deviceWidth),
        crossFadeState: showFirstMsg ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      );
    } else {
      return FlatButton.icon(
        onPressed: () => null, 
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
          size: deviceWidth / 15,
        ), 
        label: this.renderText('Try again', deviceWidth),
      );
    }
  }

  /// Render a text widget with msg and preset styles
  Widget renderText(String msg, double width) {
    return Text(
      msg,
      style: TextStyle(fontSize: width / LocalData.widthDivider, color: Colors.white),
    );
  }
}
