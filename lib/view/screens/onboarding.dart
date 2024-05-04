import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/onboarding_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/data_source/static/onboarding.dart';
import 'package:my_eccommerce_user/main.dart';
import 'package:my_eccommerce_user/view/widgets/onboarding/onboarding_button.dart';
import 'package:my_eccommerce_user/view/widgets/onboarding/onboarding_dots.dart';
import 'package:my_eccommerce_user/view/widgets/onboarding/onboarding_page.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      backgroundColor: AppColors.mainColor60,
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await sharedPreferences.clear();
              },
              child: const Text("Clear SP"),
            ),
            SizedBox(
              height: Get.height * 0.70,
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (value) {
                  controller.currentPageIndex = value;
                  controller.update();
                },
                itemCount: onBoarding.length,
                itemBuilder: (context, index) {
                  return OnBoardingPage(
                    onBoardingModel: onBoarding[index],
                  );
                },
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                OnBoardingDots(),
                SizedBox(
                  height: 10,
                ),
                OnBoardingButton()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
