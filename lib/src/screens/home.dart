import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color customColor = const Color(0xFFFFD951);
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 170,
              color: customColor,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: customColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/logo-negro.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                  ),
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => context.go("/login"),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
