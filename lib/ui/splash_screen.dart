import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_third_digital/ui/second_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
            ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SecondScreen())
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent,
        child:FlutterLogo(
            style: FlutterLogoStyle.horizontal,
            size:MediaQuery.of(context).size.height
        )
    )
    );
  }
}
