import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_reviews_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/review_card.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class ItemReviewsPage extends StatelessWidget {
  const ItemReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemReviewsPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewCard(
                      review: controller.reviews[index],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
