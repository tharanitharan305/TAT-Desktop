import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Animations extends StatefulWidget {
  Animations({required this.animationURL, required this.getOff});
  String animationURL;
  String getOff;
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
  }

  void controll() {
    // Lottie.asset('assets/animations/saving.json',
    //     controller: _animationController);
    var control = _animationController.forward();
    control.whenComplete(() => Get.offNamed(widget.getOff));
  }

  Widget build(context) {
    controll();
    return Scaffold(
      body: Container(
          child: Center(
              child: Lottie.asset(
        repeat: true,
        widget.animationURL,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        controller: _animationController,
      ))),
    );
  }
}
