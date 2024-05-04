import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class SingupButton extends StatelessWidget {
  const SingupButton({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.thirdColor10.withOpacity(0.9),
                  blurRadius: 0.2,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(5),
            child: Text(
              "SignUp".tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
