import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/data/data_source/static/onboarding.dart';
import 'package:my_eccommerce_user/main.dart';
import 'package:my_eccommerce_user/routes.dart';

class OnBoardingController extends GetxController {
  int currentPageIndex = 0;
  late PageController pageController;
  animateToTheNextPage() {
    // if I am before the last page
    if (currentPageIndex < onBoarding.length - 1) {
      currentPageIndex++;

      pageController.animateToPage(currentPageIndex,
          duration: const Duration(milliseconds: 500), curve: Easing.standard);
      // updates the dots
      update();
    } else {
      sharedPreferences.setString("step", '2');
      Get.toNamed(AppRoutes.login);
    }
  }

  animateToPage(int index) {
    currentPageIndex = index;
    pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500), curve: Easing.standard);
    // updates the dots
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
