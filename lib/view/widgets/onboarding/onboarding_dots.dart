import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_eccommerce_user/controller/onboarding_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/data_source/static/onboarding.dart';

class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onBoarding.length,
            (index) {
              bool currentIndex = controller.currentPageIndex == index;
              return SingleDot(
                isCurrentindex: currentIndex,
                onTap: () {
                  controller.animateToPage(index);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class SingleDot extends StatelessWidget {
  const SingleDot(
      {super.key, required this.isCurrentindex, required this.onTap});
  final bool isCurrentindex;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 10,
        width: isCurrentindex ? 25 : 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: isCurrentindex ? AppColors.thirdColor10 : Colors.white,
        ),
      ),
    );
  }
}
