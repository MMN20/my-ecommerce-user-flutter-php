import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/auth/login_controller.dart';
import 'package:my_eccommerce_user/core/assets/images.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/view/widgets/auth/first_auth_title.dart';
import 'package:my_eccommerce_user/view/widgets/auth/login/signup_button.dart';
import 'package:my_eccommerce_user/view/widgets/auth/second_auth_title.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: GetBuilder<LoginController>(builder: (controller) {
        return RequestStatusView(
          onErrorTap: () {
            controller.removeRequestError();
          },
          requestStatus: controller.requestStatus,
          child: Form(
            key: controller.formState,
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: [
                  const SizedBox(height: 35),
                  SizedBox(
                    height: Get.height * 0.20,
                    child: Image.asset(
                      AppImageAssets.login,
                      height: Get.height * 0.20,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // takes its textStyle from ThemeData in GetMaterialApp
                  FirstAuthTitle(
                    text: "Login".tr,
                  ),
                  const SizedBox(height: 20),

                  SecondAuthTitle(
                    text: "Login with your Email and password".tr,
                  ),
                  const SizedBox(height: 40),
                  MyTextFormField(
                    validator: (val) {
                      return validator(
                        val!,
                        3,
                        40,
                        "The username is too small!".tr,
                        "The username is too long!".tr,
                      );
                    },
                    controller: controller.emailController,
                    labelText: "Email".tr,
                    icon: const Icon(Icons.email_outlined),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<LoginController>(builder: (controller) {
                    return MyTextFormField(
                      validator: (val) {
                        return validator(
                          val!,
                          3,
                          30,
                          "The password is too small!".tr,
                          "The password is too long!".tr,
                        );
                      },
                      controller: controller.passwordController,
                      labelText: "Password".tr,
                      icon: IconButton(
                          onPressed: () {
                            controller.changeObsecureText();
                          },
                          icon: Icon(
                            controller.obsecureText
                                ? Icons.lock
                                : Icons.lock_open_outlined,
                            color: AppColors.thirdColor10,
                          )),
                      obsecureText: controller.obsecureText,
                    );
                  }),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        radius: 10,
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          controller.goToForGotPasswordPage();
                        },
                        child: Text(
                          "Forgot your password?".tr,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: GeneralButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: Text("Login".tr),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SingupButton(
                    onPressed: () {
                      controller.goToSignUpPage();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
