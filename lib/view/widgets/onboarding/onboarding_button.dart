import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/onboarding_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingController controller = Get.find();
    return MaterialButton(
      onPressed: () {
        controller.animateToTheNextPage();
      },
      color: AppColors.thirdColor10,
      child: Text(
        "Continue".tr,
        style: const TextStyle(color: AppColors.secondColor30),
      ),
    );
  }
}
