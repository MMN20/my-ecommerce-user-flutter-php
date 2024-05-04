import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class SignUpController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordAgainController;
  late TextEditingController phoneController;

  bool obsecureText = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RequestStatus requestStatus = RequestStatus.none;

  void changeObsecureText() {
    obsecureText = !obsecureText;
    // add the id 1 because i want only the password text fields to update here
    update(["1"]);
  }

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  Future<void> signUp() async {
    if (formState.currentState!.validate()) {
      if (passwordAgainController.text != passwordController.text) {
        Get.snackbar("Error!".tr, "The password fields are not equal!".tr);
        return;
      }
      requestStatus = RequestStatus.loading;
      update();
      UserModel userModel = UserModel(
        id: 0,
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
      dynamic response = await UserModel.signUp(userModel);
      requestStatus = hanldeRequestData(response);

      if (requestStatus == RequestStatus.success) {
        update();
        if (response['status'] == 'success') {
          Get.offNamed(AppRoutes.verifycode,
              arguments: {'userModel': userModel});
          return;
        } else if (response['message'] == 'users_exists') {
          Get.snackbar("fail!".tr, "This email is already been used!".tr);
          return;
        }
      }

      update();
    }
  }

  @override
  void onInit() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordAgainController = TextEditingController();
    phoneController = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
