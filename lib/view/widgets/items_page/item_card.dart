import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/core/assets/images.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.item,
      required this.onFavoriteTap,
      required this.isFavoritePage,
      this.onTap});
  final ItemModel item;
  final void Function() onFavoriteTap;
  final bool isFavoritePage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          gradient: LinearGradient(
            colors: [
              AppColors.thirdColor10.withOpacity(0.1),
              AppColors.thirdColor10.withOpacity(0.0),
            ],
            tileMode: TileMode.repeated,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Card(
          color: AppColors.secondColor30,
          elevation: 5,
          shadowColor: AppColors.thirdColor10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      "${APILinks.itemImages}/${item.imageUrl!}",
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item.itemsName!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getPriceAndCurrency(item.itemsPrice!),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    decoration: item.discount != 0
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                              if (item.discount != 0)
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Text(
                                    getPriceAndCurrency(
                                        item.priceAfterDiscount!),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${item.rating} (${item.raters})", // stars
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 10,
                                  ),
                                ],
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {},
                                child: Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      onTap: onFavoriteTap,
                                      child: Icon(
                                        item.isFavorite!
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 25,
                                        color: item.isFavorite!
                                            ? Colors.red
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    if (!isFavoritePage)
                                      InkWell(
                                        borderRadius: BorderRadius.circular(5),
                                        onTap: () {
                                          final controller =
                                              Get.find<ItemsPageController>();
                                          if (item.cartAmount == 0) {
                                            controller.addToCart(item);
                                          } else {
                                            controller.onDeleteFromCart(item);
                                          }
                                        },
                                        child: Icon(
                                          item.cartAmount == 0
                                              ? Icons.add_shopping_cart_sharp
                                              : Icons.shopping_cart_sharp,
                                          size: 25,
                                          color: item.cartAmount == 0
                                              ? null
                                              : AppColors.thirdColor10,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (item.discount != 0)
                Positioned(
                  left: 10,
                  top: 10,
                  child: Image.asset(
                    AppImageAssets.discount,
                    height: 50,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
