import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/main.dart';
import 'package:my_eccommerce_user/routes.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    if (sharedPreferences.getString("id") != null) {
      // redirect to mainScreen
      return const RouteSettings(name: AppRoutes.mainScreen);
    }

    if (sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null; // OnBoarding
  }
}
