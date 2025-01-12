// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:taskfusion/utils/appextenstion.dart';
// import '../providers/ads_controllor.dart';
import '../providers/ads_controllor.dart';
import 'onboading_view/language_view/language_view.dart';
// import 'package:get/get.dart';
// import 'package:get/get.dart';
// import '../controllers/ads_controller.dart';
// import '../controllers/ads_controller.dart';
// import 'main_screen.dart'; // Adjust the import based on your actual MainScreen location
// Import the custom theme

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Get instance of AdsController

  @override
  void initState() {
    super.initState();
    Get.put(AdsController());

    // Delay to show the ad or navigate to the main screen after a few seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        // If the ad is not ready, directly move to the Home Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LanguageView()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.widths,
        height: context.heightss,
        color: Colors.white,
        child: Center(
          child: Image.asset(
            width: context.widths,
            height: context.heightss,
            "assets/Picsart_24-12-11_18-44-07-926.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
