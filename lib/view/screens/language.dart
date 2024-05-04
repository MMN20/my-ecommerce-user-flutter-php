import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/language_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LanguageController());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Choose your language",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "أختر لغتك",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              controller.setLanguage("en");
            },
            style: ElevatedButton.styleFrom(
                //   padding: const EdgeInsets.all(10),
                minimumSize: const Size(140, 30),
                backgroundColor: AppColors.thirdColor10,
                foregroundColor: AppColors.secondColor30,
                textStyle: const TextStyle(fontSize: 15)),
            child: const Text("English"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              controller.setLanguage("ar");
            },
            style: ElevatedButton.styleFrom(
                //   padding: const EdgeInsets.all(10),
                minimumSize: const Size(140, 30),
                backgroundColor: AppColors.thirdColor10,
                foregroundColor: AppColors.secondColor30,
                textStyle: const TextStyle(fontSize: 15)),
            child: const Text("العربية"),
          ),
        ],
      ),
    );
  }
}
