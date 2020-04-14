
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'home_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
      mainScreen();
  }

  Future<void> mainScreen() async {
    Duration duration = Duration(seconds: 5);
    await Future.delayed(duration);
    print('Calledz');

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            height: MediaQuery.of(context).copyWith().size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffFF9999),
              Color(0xffFF6666),
            ])),
          ),
          Center(

            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Delicious ",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Recipes",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),
                  ],
                ),

                Card(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/app_icon.png'),
                    radius: 150,
                    backgroundColor: Color(0xffFF6666),
                  ),
                  shape: CircleBorder(),
                  elevation: 50,
                ),
                JumpingText(
                  'Opening...',
                  style: TextStyle(
                      fontSize: 50,

                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
