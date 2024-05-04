import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.obsecureText = false,
      this.validator,
      this.hintText});
  final String labelText;
  final Widget icon;
  final TextEditingController controller;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obsecureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.thirdColor10),
        ),
        fillColor: AppColors.thirdColor10.withOpacity(0.1),
        filled: true,
        labelText: labelText,
        suffixIcon: icon,
      ),
    );
  }
}
