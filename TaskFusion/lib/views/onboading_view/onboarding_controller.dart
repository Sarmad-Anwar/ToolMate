import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskfusion/views/home.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  int index = 0;
  List<String> onBoardingImages = [
    "assets/Picsart_24-12-10_21-42-28-116.jpg",
    "assets/Picsart_24-12-10_21-49-07-678.jpg",
    "assets/Picsart_24-12-10_21-38-37-250.jpg",
    // "assets/IMG_20241211_124605.jpg"
  ];

  onChangeIndex(int indexx) {
    index = indexx;
    update();
  }

  onNextPage() async {
    if (index == 2) {
      Get.offAll(() => Home());
      return;
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
}
