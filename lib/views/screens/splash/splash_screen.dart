import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../utils/app_constants/image_constants.dart';
import '../home/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            assetImage(path: appLogo),
            30.height,
            progressIndicator
          ],
        ),
      ),
    );
  }




  void startTimer() {
    Timer( const Duration(seconds: 3,),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    },);
  }
  }

