import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Animation? alignTween;
  Animation? alignSTween;
  AnimationController? controller;
  AnimationController? controllerImg;
  Tween<double>? turnsTween;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, 'home');
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    alignTween = Tween<Alignment>(
      begin: const Alignment(-3.1, 0.2),
      end: const Alignment(-0.8, 0.2),
    ).animate(controller!);
    alignSTween = Tween<Alignment>(
      begin: const Alignment(-3.1, 0.3),
      end: const Alignment(-0.6, 0.3),
    ).animate(controller!);
    controller!.addListener(() {
      setState(() {});
    });
    controller!.forward();

    controllerImg = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    turnsTween = Tween<double>(begin: 0, end: 1);
    controllerImg!.addListener(() {
      setState(() {});
    });
    controllerImg!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff5915e3),
                  Colors.greenAccent,
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.8),
            child: RotationTransition(
              turns: turnsTween!.animate(controllerImg!),
              child: Image.asset("assets/image/bg.png"),
            ),
          ),
          Align(
            alignment: alignTween!.value,
            child: const Text(
              "Welcome The",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: alignSTween!.value,
            child: const Text(
              "Planet App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment(0, 0.7),
              child: Text(
                "Our Sun (a star) and all the planets around it are part of a galaxy known as the Milky Way Galaxy. A galaxy is a large group of stars, gas, and dust bound together by gravity. They come in a variety of shapes and sizes. The Milky Way is a large barred spiral galaxy. All the stars we see in the night sky are in our own Milky Way Galaxy.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controllerImg!.dispose();
    super.dispose();
  }
}
