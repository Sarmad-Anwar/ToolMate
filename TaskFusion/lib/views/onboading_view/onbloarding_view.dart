import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskfusion/views/onboading_view/onboarding_controller.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return GetBuilder<OnboardingController>(builder: (context) {
      return PageView.builder(
          controller: controller.pageController,
          itemCount: controller.onBoardingImages.length,
          onPageChanged: controller.onChangeIndex,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: controller.onNextPage,
              child: Image.asset(
                controller.onBoardingImages[index],
                fit: BoxFit.cover,
              ),
            );
          });
    });
  }
}
