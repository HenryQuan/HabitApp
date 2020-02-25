import 'package:HabitApp/src/core/LocalData.dart';
import 'package:HabitApp/src/core/Utils.dart';
import 'package:flutter/material.dart';

/// IntroPage class
class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}


class _IntroPageState extends State<IntroPage> {
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  double opacity4 = 0.0;
  double opacity5 = 0.0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        opacity1 = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 3)).then((_) {
      setState(() {
        opacity2 = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 5)).then((_) {
      setState(() {
        opacity3 = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 7)).then((_) {
      setState(() {
        opacity4 = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 10)).then((_) {
      setState(() {
        opacity5 = 1.0;
      });
    });

    final deviceWidth = Utils.getBestWidth(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox.shrink(),
                this.renderFadeText('Hello World', opacity1, deviceWidth),
                this.renderFadeText('Hello World', opacity2, deviceWidth),
                this.renderFadeText('Hello World', opacity3, deviceWidth),
                this.renderFadeText('Hello World', opacity4, deviceWidth),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: opacity5,
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton.icon(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (opacity5 == 0) return;
                        Navigator.pushReplacementNamed(context, '/home');
                        // Set first launch to false
                        LocalData().updateFirstLaunch(false);
                      }, 
                      label: Text('Start a new habit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget renderFadeText(String msg, opacity, width) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 300),
      opacity: opacity,
      child: Text(
        msg,
        style: TextStyle(fontSize: width / 20),
      ),
    );
  }
}
