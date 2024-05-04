import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/item_details_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/item_details_bottom_navigation_bar.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/item_image_list.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/reviews.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/specs_list.dart';
import 'package:my_eccommerce_user/view/widgets/item_details_page/your_review.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemDetailsPageController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        color: AppColors.thirdColor10,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: 60,
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return ItemDetailsBottomNavigationBar(
                isAddedToCart: controller.isAddedToCart,
                isLike: controller.currentItem.isFavorite!,
                addToCartFunc: () {
                  controller.addToCart();
                },
                onCartTap: () {
                  controller.goToCartPage();
                },
                likeUnlike: () {
                  controller.likeUnlike();
                },
                isLoading: controller.isBottomAppBarLoading,
                onDelete: () {
                  controller.onDeleteFromCart();
                },
              );
            }),
      ),
      backgroundColor: AppColors.mainColor60,
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: ListView(
                children: [
                  //! Main image
                  SizedBox(
                    height: Get.height * 0.50,
                    child: controller.flutterImages.isNotEmpty
                        ? controller
                            .flutterImages[controller.selectedImageIndex]
                        : null,
                  ),
                  const SizedBox(height: 10),
                  //! All images
                  SizedBox(
                    height: Get.height * 0.1,
                    child: ListView.builder(
                      itemCount: controller.flutterImages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ItemImagesList(index: index);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  //! Descroption and specs
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! name
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                controller.currentItem.itemsName!,
                                style: const TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        //! price
                        Row(
                          children: [
                            const Text(
                              "Price: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              getPriceAndCurrency(
                                  controller.currentItem.itemsPrice!),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                // fontSize: 12,
                                fontWeight: controller.currentItem.discount == 0
                                    ? FontWeight.bold
                                    : null,
                                decoration: controller.currentItem.discount != 0
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 5),
                            if (controller.currentItem.discount != 0)
                              Text(
                                getPriceAndCurrency(
                                    controller.currentItem.priceAfterDiscount!),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  // fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )
                          ],
                        ),
                        const Divider(),
                        const Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(controller.currentItem.itemsDesc!),
                        const SizedBox(height: 10),
                        const Divider(),
                        const Text(
                          "Specifications",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const SpecsList(),
                        // I don't want a space if there is no review
                        if (controller.currentUserReview != null)
                          const SizedBox(height: 10),
                        //! your review
                        if (controller.currentUserReview != null) YourReview(),
                        const Divider(),
                        if (controller.currentUserReview == null)
                          GeneralButton(
                              onPressed:
                                  controller.showRatingBottomSheetForAdding,
                              child: const Text("Add your review")),
                        //! Reviews
                        Reviews(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
