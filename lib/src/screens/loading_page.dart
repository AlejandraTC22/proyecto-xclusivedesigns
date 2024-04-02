import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        GoRouter.of(context).go('/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFFFD951);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: true),
              child: Container(
                height: 100,
                color:
                    customColor, // Puedes cambiar el color según tus necesidades
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Splash Screen',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logo.png', // Ajusta la ruta según la ubicación de tu logo
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: false),
              child: Container(
                height: 100,
                color: Colors
                    .blue, // Puedes cambiar el color según tus necesidades
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
