import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/main_screens_window_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class CustomBottomNavigationBar extends GetView<MainScreensWindowController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          height: Get.height * 0.07,
          color: AppColors.thirdColor10.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                controller.mainScreens.length,
                (index) {
                  return AnimatedScale(
                    duration: const Duration(milliseconds: 150),
                    scale: controller.currentIndex == index ? 1.2 : 1,
                    child: IconButton(
                      onPressed: () {
                        controller.changeCurrentIndex(index);
                      },
                      icon: controller.mainScreens[index]['icon'],
                      color: controller.currentIndex == index
                          ? AppColors.secondColor30
                          : AppColors.thirdColor10,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
