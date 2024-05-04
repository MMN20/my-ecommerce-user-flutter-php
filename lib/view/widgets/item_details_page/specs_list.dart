import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';

class SpecsList extends StatelessWidget {
  const SpecsList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.specs.map((e) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.circle,
                    color: AppColors.thirdColor10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(child: Text("${e.specValue}")),
                ],
              ))
        ],
      ),
    );
  }
}
