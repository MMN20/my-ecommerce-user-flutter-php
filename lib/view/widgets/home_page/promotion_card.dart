import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/keep_child_alive.dart';

class PromotionCard extends GetView<HomePageController> {
  const PromotionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.3,
      child: Column(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  onPageChanged: (index) {
                    controller.changeCurrentPromotionPage(index);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.promotions.length,
                  itemBuilder: (context, index) {
                    print(
                        "${APILinks.promotionImages}/${controller.promotions[index].promotionsImageUrl!}");
                    return KeepChildAlive(
                      child: CachedNetworkImage(
                        imageUrl:
                            "${APILinks.promotionImages}/${controller.promotions[index].promotionsImageUrl!}",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          GetBuilder<HomePageController>(
            builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.promotions.length,
                  (index) {
                    return AnimatedContainer(
                      decoration: BoxDecoration(
                          color: controller.currentPromotionIndex == index
                              ? Colors.black
                              : Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 7,
                      width:
                          controller.currentPromotionIndex == index ? 15 : 10,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
