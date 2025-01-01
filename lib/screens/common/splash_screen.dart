import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talenties/backend/backend.dart';
import 'package:talenties/constants/colors.dart';
import 'join_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.slot15min,
  }) : super(key: key);

  final DocumentReference? slot15min;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => JoinScreen(slot15min: widget.slot15min),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/logo.png'),
          ),
          Positioned(
            bottom: kIsWeb ? 0 : 40,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/videosdk_text.png',
              fit: BoxFit.scaleDown,
              scale: 4,
            ),
          )
        ],
      ),
    );
  }
}
