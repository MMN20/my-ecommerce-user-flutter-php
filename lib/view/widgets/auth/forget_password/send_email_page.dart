import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';

class SendEmailPage extends StatelessWidget {
  const SendEmailPage(
      {super.key,
      required this.globalKey,
      required this.emailController,
      required this.onPressed});
  final Key globalKey;
  final TextEditingController emailController;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("A verification code will be sent to:"),
        const SizedBox(height: 20),
        Form(
          key: globalKey,
          child: MyTextFormField(
            controller: emailController,
            icon: const Icon(Icons.email_outlined),
            labelText: "Email",
            hintText: "Enter your email here",
            obsecureText: false,
            validator: (val) {
              return validator(
                val!,
                1,
                val.length,
                "Please enter the Email",
                "",
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        GeneralButton(
          onPressed: onPressed,
          child: const Text("Submit"),
        )
      ],
    );
  }
}
