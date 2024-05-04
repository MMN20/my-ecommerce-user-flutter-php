import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RequestStatus requestStatus = RequestStatus.none;
  late PageController pageController;
  late Timer _timer;
  int timeLeft = 20;
  bool resendButtonLoading = false;

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  Future<void> sendVerificationCode() async {
    if (formState.currentState!.validate()) {
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await UserModel.sendVerificationCodeForPasswordUpdate(
          emailController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          // because here the PageView is now removed from the widget tree and the pageController is not attached to any PageView,
          // so we must rebuild the Tree to make the PageView attached to the controller.
          update();
          initTimer();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Easing.emphasizedAccelerate,
            );
          });
        }
      } else {
        Get.snackbar("Error", "Some error occurred!");
      }
      update();
    }
  }

  Future<void> verifyCode(String code) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await UserModel.verifyCodeForResetingPassword(
        code, emailController.text);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        Get.offNamed(AppRoutes.resetPassword,
            arguments: {"email": emailController.text});
      }
    } else {
      Get.snackbar("Error", "Some error occurred!");
    }
    update();
  }

  Future<void> resendCode() async {
    resendButtonLoading = true;
    update();
    dynamic response = await UserModel.resendVerifyCode(emailController.text);
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      initTimer();
      resendButtonLoading = false;
    }
    update();
  }

  void initTimer() {
    timeLeft = 20;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
      timeLeft--;
      if (timeLeft == 0) {
        timer.cancel();
        update();
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  void onInit() {
    String emailFromPreviousRoute = Get.arguments['email'];
    emailController = TextEditingController(text: emailFromPreviousRoute);
    pageController = PageController();
    super.onInit();
  }
}
