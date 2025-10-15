import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const homePage(),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            // Fade transition
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: size.width * 0.55,
          height: size.width * 0.4,
          child: Lottie.asset(
            'assets/animations/loading.json',
            fit: BoxFit.contain,
            repeat: true,
          ),
        ),
      ),
    );
  }
}
