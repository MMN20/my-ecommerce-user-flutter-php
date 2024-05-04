import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage(
      {super.key,
      required this.onSubmit,
      required this.showTime,
      required this.timeLeft,
      required this.onResendPressed});
  final void Function(String) onSubmit;
  final bool showTime;
  final int timeLeft;
  final void Function() onResendPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OtpTextField(
          enabledBorderColor: AppColors.thirdColor10,
          autoFocus: true,
          fieldWidth: 50,
          borderRadius: BorderRadius.circular(20),
          numberOfFields: 5,
          borderColor: AppColors.thirdColor10,
          showFieldAsBox: true,
          onSubmit: onSubmit,
        ),
        const SizedBox(height: 20),
        showTime
            ? Text(timeLeft.toString())
            : GeneralButton(
                onPressed: onResendPressed, child: const Text("Resend"))
      ],
    );
  }
}
