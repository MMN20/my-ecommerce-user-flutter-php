import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/main.dart';
import 'package:my_eccommerce_user/routes.dart';

class LanguageController extends GetxController {
  Future<void> setLanguage(String localeID) async {
    await sharedPreferences.setString("locale", localeID);
    // step 1 is the onBoarding screen
    await sharedPreferences.setString("step", "1");
    await Get.updateLocale(Locale(localeID));
    Get.toNamed(AppRoutes.onBoarding);
  }
}
