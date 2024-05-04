import 'dart:async';

import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/functions/set_user_sharedpref.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/main.dart';
import 'package:my_eccommerce_user/routes.dart';

class VerifyCodeController extends GetxController {
  late UserModel user;
  RequestStatus requestStatus = RequestStatus.none;
  late Timer timer;
  int timeLeft = 5;
  late bool timerRunning;

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  Future<void> verifyCode(String code) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await user.verifyCode(code);

    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        Get.snackbar("Success".tr, "The Account has been approved!".tr);

        await saveUserSharedPrefs(
            user.id.toString(), user.email, user.username);
        // go to Home Page
        await Get.offAllNamed(AppRoutes.homePage);
      } else {
        requestStatus = RequestStatus.none;
        update();
        Get.snackbar("Fail".tr, "The is code not correct!");
        return;
      }
    }
    update();
  }

  Future<void> resendCode() async {
    initTimer();
    await user.resendCode();
  }

  void initTimer() {
    timerRunning = true;
    timeLeft = 20;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        update();
        timeLeft--;
        if (timeLeft == 0) {
          timerRunning = false;
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    if (timer.isActive) {}
    super.dispose();
  }

  @override
  void onInit() {
    user = Get.arguments['userModel'];
    initTimer();
    super.onInit();
  }
}
