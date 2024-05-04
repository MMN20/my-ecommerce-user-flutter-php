import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/auth/signup_controller.dart';
import 'package:my_eccommerce_user/core/assets/images.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/view/widgets/auth/first_auth_title.dart';
import 'package:my_eccommerce_user/view/widgets/auth/second_auth_title.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController(), permanent: true);
    return Scaffold(
      body: Form(
        key: controller.formState,
        child: GetBuilder<SignUpController>(
          builder: (controller) {
            return SafeArea(
              child: RequestStatusView(
                onErrorTap: () {
                  controller.removeRequestError();
                },
                requestStatus: controller.requestStatus,
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
                    FirstAuthTitle(
                      text: "SignUp".tr,
                    ),
                    const SizedBox(height: 20),
                    SecondAuthTitle(
                      text: "Register a new account".tr,
                    ),
                    const SizedBox(height: 40),
                    MyTextFormField(
                      validator: (val) {
                        return validator(
                            val!,
                            3,
                            30,
                            "The username is too small!".tr,
                            "The username is too long!".tr);
                      },
                      controller: controller.usernameController,
                      labelText: "Username".tr,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 10),
                    MyTextFormField(
                      validator: (val) {
                        return validator(val!, 1, val.length,
                            "The email field can't be empty!".tr, "");
                      },
                      controller: controller.emailController,
                      labelText: "Email".tr,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<SignUpController>(
                        assignId: true,
                        id: "1",
                        builder: (controller) {
                          return Column(
                            children: [
                              MyTextFormField(
                                validator: (val) {
                                  return validator(val!, 6, val.length,
                                      "The password is too small!".tr, "");
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
                              ),
                              const SizedBox(height: 10),
                              MyTextFormField(
                                validator: (val) {
                                  return validator(val!, 6, val.length,
                                      "The password is too small!".tr, "");
                                },
                                controller: controller.passwordAgainController,
                                labelText: "Password again".tr,
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
                              ),
                            ],
                          );
                        }),
                    const SizedBox(height: 10),
                    MyTextFormField(
                      validator: (val) {
                        return validator(
                            val!,
                            6,
                            15,
                            "The phone number is too small!".tr,
                            "The phone number is too long!".tr);
                      },
                      controller: controller.phoneController,
                      labelText: "Phone Number".tr,
                      icon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: GeneralButton(
                        onPressed: () {
                          controller.signUp();
                        },
                        child: Text("Register".tr),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
