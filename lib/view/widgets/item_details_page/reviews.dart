import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/review_card.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemDetailsPageController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Reviews ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
                "${controller.currentItem.rating} (${controller.currentItem.raters})"),
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            if (controller.currentItem.raters! > 0)
              MaterialButton(
                //! here navigate to all reviews page
                onPressed: () {
                  controller.goToReviewsPage();
                },
                child: const Text(
                  "View all",
                  style: TextStyle(color: AppColors.thirdColor10),
                ),
              )
          ],
        ),
        ...List.generate(
          controller.reviews.length,
          (index) => ReviewCard(
            review: controller.reviews[index],
          ),
        ),
      ],
    );
  }
}
