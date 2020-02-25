import 'dart:async';

import 'Package:HabitApp/src/core/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

/// There are two modes for this wiget
enum ResultMode {
  completed,
  failed
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

  @override
  void initState() {
    super.initState();
  
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

    final completed = widget.mode == ResultMode.completed;

    // Update theme to be dark only here
    return AnnotatedRegion<SystemUiOverlayStyle>(
      child: AnimatedContainer(
        height: containerHeight,
        width: containerWidth,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: completed ? Colors.green[600] : Colors.red[700],
          borderRadius: containerRadius
        ),
        curve: Curves.linearToEaseOut,
        child: this.renderIcon(),
      ),
      value: SystemUiOverlayStyle(
        // IOS, match current screen colour
        statusBarBrightness: Brightness.dark,
        // Android
        statusBarColor: completed ? Colors.green[900] : Colors.red[900],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: completed ? Colors.green[900] : Colors.red[900],
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
                  child: this.renderIconWidget(),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: textOpacity,
                  child: this.renderAccordingMode(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: shareOpacity,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: FlatButton.icon(
                  onPressed: () {
                    Share.share('Hello World');
                  }, 
                  icon: Icon(Icons.share, color: Colors.white), 
                  label: Text('Share with friends', style: TextStyle(color: Colors.white))
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  /// Render the correct icon depending on whether user completes or fails
  Widget renderIconWidget() {
    IconData icon = widget.mode == ResultMode.completed ? Icons.check : Icons.close;

    return Icon(
      icon, 
      size: iconSize,
      color: Colors.white,
    );
  }

  /// Render cross fade text or just fade in a button
  Widget renderAccordingMode() {
    if (widget.mode == ResultMode.completed) {
      return AnimatedCrossFade(
        firstCurve: Curves.elasticOut,
        secondCurve: Curves.elasticOut,
        duration: Duration(milliseconds: 200),
        firstChild: renderText('All good', deviceWidth),
        secondChild: renderText('Come back tomorrow :)', deviceWidth),
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
      style: TextStyle(fontSize: width / 20, color: Colors.white),
    );
  }
}
