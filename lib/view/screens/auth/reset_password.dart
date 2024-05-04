import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/auth/reset_password_controller.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());
    return Scaffold(
      body: GetBuilder<ResetPasswordController>(builder: (controller) {
        return RequestStatusView(
          onErrorTap: () {
            controller.removeRequestError();
          },
          requestStatus: controller.requestStatus,
          child: Form(
            key: controller.formState,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Reset the password for:"),
                  Text(controller.email),
                  const SizedBox(height: 20),
                  MyTextFormField(
                    obsecureText: controller.obsecureText,
                    validator: (val) {
                      return validator(val!, 6, val.length,
                          "The password is too short!", "");
                    },
                    labelText: "Password",
                    icon: IconButton(
                        onPressed: controller.changeObsecureText,
                        icon: Icon(controller.obsecureText
                            ? Icons.lock
                            : Icons.lock_open_outlined)),
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 15),
                  MyTextFormField(
                    obsecureText: controller.obsecureText,
                    validator: (val) {
                      return validator(val!, 6, val.length,
                          "The password is too short!", "");
                    },
                    labelText: "Password again",
                    icon: IconButton(
                        onPressed: controller.changeObsecureText,
                        icon: Icon(controller.obsecureText
                            ? Icons.lock
                            : Icons.lock_open_outlined)),
                    controller: controller.passwordAgainController,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: SizedBox(
                      width: double.infinity,
                      child: GeneralButton(
                        onPressed: () {
                          controller.resetPassword();
                        },
                        child: const Text("Reset password"),
                      ),
                    ),
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
