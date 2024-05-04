import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/favorite_page_controller.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/item_card.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/items_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritePageController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GetBuilder<FavoritePageController>(builder: (controller) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 3),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                ItemModel item = controller.items[index];
                return ItemCard(
                  item: item,
                  onFavoriteTap: () {
                    final controller = Get.find<FavoritePageController>();
                    controller.likeUnlike(item);
                  },
                  isFavoritePage: true,
                  onTap: () {
                    controller.goToItemDetailsPage(item);
                  },
                );
              },
            );
          }),
        ));
  }
}
