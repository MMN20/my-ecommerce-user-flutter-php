import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/item_card.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.controller});
  final ItemsPageController controller;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: controller.showSearchedItems
          ? controller.searchedItems.length
          : controller.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 3,
      ),
      itemBuilder: (context, index) {
        ItemModel item = controller.showSearchedItems
            ? controller.searchedItems[index]
            : controller.items[index];
        return InkWell(
          onTap: () {
            controller.goToItemDetailsPage(item);
          },
          child: ItemCard(
            onFavoriteTap: () {
              final controller = Get.find<ItemsPageController>();
              controller.likeUnlike(item);
            },
            item: item,
            isFavoritePage: false,
          ),
        );
      },
    );
  }
}
