import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;
  late String email;
  RequestStatus requestStatus = RequestStatus.none;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool obsecureText = true;

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  Future<void> resetPassword() async {
    if (formState.currentState!.validate()) {
      if (passwordAgainController.text != passwordController.text) {
        Get.snackbar("Error!", "The password fields are not identical!");
        return;
      }
      requestStatus = RequestStatus.loading;
      update();
      dynamic response =
          await UserModel.resetPassword(email, passwordController.text);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        if (response['status'] == 'success') {
          Get.offAllNamed(AppRoutes.login);
          Get.snackbar("Success", "The password was updated successfully");
        } else {
          Get.snackbar(
              "Error!", "There was an error during the password reset!");
        }
      }
      update();
    }
  }

  void changeObsecureText() {
    obsecureText = !obsecureText;
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    super.onInit();
  }
}
