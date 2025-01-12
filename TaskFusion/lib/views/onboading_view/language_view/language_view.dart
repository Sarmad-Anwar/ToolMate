import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskfusion/utils/appcolors.dart';
import 'package:taskfusion/views/onboading_view/language_view/language_controller.dart';
import 'package:taskfusion/views/onboading_view/onbloarding_view.dart';
import '../../../utils/appextenstion.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LanguageController());
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: GetBuilder<LanguageController>(builder: (context) {
        return Column(
          children: [
            SafeArea(
              child: Material(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(color: klightgreyColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Languages",
                        style: TextStyle(
                            color: kblackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      if (controller.currentIndex != -1)
                        GestureDetector(
                          onTap: () {
                            Get.to(() => OnBoardingView());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kredColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Text(
                              "Select",
                              style:
                                  TextStyle(color: kwhiteColor, fontSize: 16),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBoxExtension(20).heightboxss,
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(controller.languages.length, (index) {
                      return GestureDetector(
                        onTap: () => controller.updateLanguage(index),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.languages[index],
                                    style: TextStyle(
                                        color: kblackColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                controller.currentIndex == index
                                                    ? kredColor
                                                    : kblackColor,
                                            width: 2)),
                                    padding: EdgeInsets.all(2.5),
                                    child: controller.currentIndex == index
                                        ? Container(
                                            height: Get.height,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color: kredColor,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : SizedBox(),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: klightgreyColor,
                            )
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ))
          ],
        );
      }),
    );
  }
}
