import 'package:flutter/services.dart';
import 'package:habit/src/core/LocalData.dart';
import 'package:habit/src/core/Utils.dart';
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
  void setState(fn) {
    // Somehow, it sets state after disposed
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (!Utils.of(context).isTablet()) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    
    // Generally, 1000ms to 1500ms for each label
    // However, if it is too long, give it a bit more time
    
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        opacity1 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 2500)).then((_) {
      setState(() {
        opacity2 = 1.0;
      });
    });

    Future.delayed(Duration(seconds: 5)).then((_) {
      setState(() {
        opacity3 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 8500)).then((_) {
      setState(() {
        opacity4 = 1.0;
      });
    });

    Future.delayed(Duration(milliseconds: 10000)).then((_) {
      setState(() {
        opacity5 = 1.0;
      });
    });

    final deviceWidth = Utils.of(context).getBestWidth();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),  
          child: Column(
            // Put the button at the button
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Use this as a margin
              SizedBox.shrink(),
              this.renderFadeText('One minute...', opacity1, deviceWidth),
              this.renderFadeText('Just one minute everyday...', opacity2, deviceWidth),
              this.renderFadeText('It is that easy to\nstart a new habit...', opacity3, deviceWidth),
              this.renderFadeText('So... Why not ...', opacity4, deviceWidth),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: opacity5,
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton.icon(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (opacity5 == 0) return;
                      // Set first launch to false
                      LocalData.shared.updateFirstLaunch(false);
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    label: Text(
                      'Start a new habit now',
                      style: TextStyle(fontSize: deviceWidth / LocalData.widthDivider),
                    ),
                  ),
                ),
              ),
            ],
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
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: width / LocalData.widthDivider),
      ),
    );
  }
}
