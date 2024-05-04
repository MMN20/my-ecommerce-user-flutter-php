import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/home_page/category_card.dart';
import 'package:my_eccommerce_user/view/widgets/home_page/home_page_text.dart';
import 'package:my_eccommerce_user/view/widgets/home_page/offers_card.dart';
import 'package:my_eccommerce_user/view/widgets/home_page/promotion_card.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("======================== HomePage");
    final controller = Get.put(HomePageController());
    return GetBuilder<HomePageController>(builder: (controller) {
      return RequestStatusView(
        onErrorTap: controller.removeRequestError,
        requestStatus: controller.requestStatus,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: controller.goToFavoritePage,
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                const PromotionCard(),
                const SizedBox(height: 10),
                const HomePageText(
                  text: "Top categories",
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: Get.height * 0.2,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        categoryModel: controller.categories[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const HomePageText(
                  text: "Offers",
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: Get.height * 0.21,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.offers.length,
                    itemBuilder: (context, index) {
                      // offers item
                      return OffersCard(
                        itemModel: controller.offers[index],
                        onTap: () {
                          controller
                              .goToItemDetailsPage(controller.offers[index]);
                        },
                        onLikeTap: () {
                          controller.likeUnlike(controller.offers[index]);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80)
              ],
            ),
          ),
        ),
      );
    });
  }
}
