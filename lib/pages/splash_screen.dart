import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';//para que funcione las imagenes de svg

class SplashScreen extends StatelessWidget {

  const SplashScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/icons/animal_3.svg'), // o usa otro asset visible
      ),
    );
  }
}
