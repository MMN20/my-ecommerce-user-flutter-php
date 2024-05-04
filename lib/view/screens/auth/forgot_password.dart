import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/auth/forgot_password_controller.dart';
import 'package:my_eccommerce_user/view/widgets/auth/forget_password/send_email_page.dart';
import 'package:my_eccommerce_user/view/widgets/auth/forget_password/verification_page.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: GetBuilder<ForgotPasswordController>(builder: (controller) {
        return RequestStatusView(
          onErrorTap: () {
            controller.removeRequestError();
          },
          requestStatus: controller.requestStatus,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              children: [
                SendEmailPage(
                  emailController: controller.emailController,
                  globalKey: controller.formState,
                  onPressed: () {
                    controller.sendVerificationCode();
                  },
                ),
                controller.resendButtonLoading
                    ? const Center(child: CircularProgressIndicator())
                    : VerificationPage(
                        onResendPressed: () async {
                          await controller.resendCode();
                        },
                        onSubmit: (val) {
                          controller.verifyCode(val);
                        },
                        showTime: controller.timeLeft > 0,
                        timeLeft: controller.timeLeft,
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
