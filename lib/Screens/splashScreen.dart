import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key, required this.width, required this.height});
  double width;
  double height;

  @override
  Widget build(context) {
    return Lottie.asset('animations/tatAni.json',
        repeat: true, width: width, height: height);
  }
}
