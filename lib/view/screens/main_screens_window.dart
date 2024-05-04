import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/main_screens_window_controller.dart';
import 'package:my_eccommerce_user/view/widgets/custom_bottom_navigation_bar.dart';

class MainScreensWindow extends StatelessWidget {
  const MainScreensWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainScreensWindowController(), permanent: true);
    return Scaffold(
        body: SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              controller.mainScreens.length,
              (index) => controller.mainScreens[index]['widget'],
            ),
          ),
          GetBuilder(
              init: controller,
              builder: (controller) {
                return Positioned(
                    left: 10,
                    right: 10,
                    bottom: 5,
                    child: CustomBottomNavigationBar());
              })
        ],
      ),
    ));
  }
}
