import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/auth/verify_code_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyCodeController());
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Code Verification".tr),
        ),
      ),
      body: Center(
        child: GetBuilder<VerifyCodeController>(builder: (controller) {
          return RequestStatusView(
            onErrorTap: () {
              controller.removeRequestError();
            },
            requestStatus: controller.requestStatus,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Enter the verification code that was sent to:".tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        "${controller.user.email}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    enabledBorderColor: AppColors.thirdColor10,
                    autoFocus: true,
                    fieldWidth: 50,
                    borderRadius: BorderRadius.circular(20),
                    numberOfFields: 5,
                    borderColor: AppColors.thirdColor10,
                    showFieldAsBox: true,
                    onSubmit: (String code) {
                      controller.verifyCode(code);
                    },
                  ),
                  const SizedBox(height: 20),
                  controller.timerRunning
                      ? Text(controller.timeLeft.toString())
                      : GeneralButton(
                          onPressed: () {
                            controller.resendCode();
                          },
                          child: Text("Resend".tr))
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
