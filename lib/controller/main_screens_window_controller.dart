import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/data/data_source/remote/user_data.dart';
import 'package:my_eccommerce_user/view/screens/cart_page.dart';
import 'package:my_eccommerce_user/view/screens/notifications_page.dart';
import 'package:my_eccommerce_user/view/screens/home_page.dart';
import 'package:my_eccommerce_user/view/screens/settings_page.dart';
import 'package:my_eccommerce_user/view/widgets/keep_child_alive.dart';

class MainScreensWindowController extends GetxController {
  List<Map> mainScreens = [
    {
      "widget": const KeepChildAlive(child: HomePage()),
      "icon": const Icon(Icons.home),
    },
    {
      "widget": const KeepChildAlive(child: NotificationsPage()),
      "icon": const Icon(Icons.notifications),
    },
    {
      "widget": const CartPage(),
      "icon": const Icon(Icons.shopping_cart_outlined),
    },
    {
      "widget": const KeepChildAlive(child: SettingsPage()),
      "icon": const Icon(Icons.settings),
    },
  ];

  int currentIndex = 0;

  PageController pageController = PageController();

  void changeCurrentIndex(int i) {
    if (i != currentIndex) {
      currentIndex = i;
      pageController.jumpToPage(i);

      update();
    }
  }

  Future<void> updateTheToken() async {
    String token = await FirebaseMessaging.instance.getToken() ?? "none";
    await UserData.updateToken(token);
  }

  @override
  void onInit() {
    updateTheToken();
    super.onInit();
  }
}
