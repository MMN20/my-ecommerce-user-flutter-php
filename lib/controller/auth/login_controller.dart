import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/functions/set_user_sharedpref.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obsecureText = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RequestStatus requestStatus = RequestStatus.none;

  void changeObsecureText() {
    obsecureText = !obsecureText;
    update();
  }

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  Future<void> login() async {
    if (formState.currentState!.validate()) {
      UserModel user = UserModel(
        id: 0,
        email: emailController.text,
        password: passwordController.text,
        username: "",
      );
      requestStatus = RequestStatus.loading;
      update();
      dynamic response = await user.login();
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          if (user.isApproved!) {
            Get.offAllNamed(AppRoutes.mainScreen);
            saveUserSharedPrefs(user.id.toString(), user.email, user.username);
          } else {
            // go to verification page
            Get.toNamed(AppRoutes.verifycode, arguments: {"userModel": user});
          }
        } else {
          Get.snackbar(
              "Login Failed".tr, "The email or the password are worng!".tr);
        }
      }
      update();
    }
  }

  void goToForGotPasswordPage() {
    Get.toNamed(AppRoutes.forgetPassword,
        arguments: {'email': emailController.text});
  }

  void goToSignUpPage() {
    Get.toNamed(AppRoutes.signUp);
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }
}
