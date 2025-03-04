import 'dart:async';

import 'package:chatboat/ui/page_one.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => PageOne())));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff27B1B2),
      body: Stack(
        children: [
          Image(image: AssetImage('assets/image 20.png')),
          Center(
            child: Container(
              height: 140,
              width: 140,
              child: Image(image: AssetImage('assets/chat icon.png')),
            ),
          ),
        ],
      ),
    );
  }
}
