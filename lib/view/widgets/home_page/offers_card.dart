import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/core/utils/currency.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';

class OffersCard extends StatelessWidget {
  const OffersCard(
      {super.key,
      required this.itemModel,
      required this.onTap,
      required this.onLikeTap});
  final ItemModel itemModel;
  final void Function() onTap;
  final void Function() onLikeTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Card(
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
          elevation: 10,
          margin: const EdgeInsets.only(right: 8, bottom: 5),
          child: ClipRRect(
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Center(
                          child: Image.network(
                            "${APILinks.itemImages}/${itemModel.imageUrl}",
                            fit: BoxFit.fill,
                          ),
                        ),
                        IconButton(
                            onPressed: onLikeTap,
                            icon: itemModel.isFavorite!
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(
                                    Icons.favorite_border,
                                    color: AppColors.thirdColor10,
                                  )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.thirdColor10,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemModel.itemsName!,
                              style: const TextStyle(
                                color: AppColors.mainColor60,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getPriceAndCurrency(itemModel.itemsPrice!),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: itemModel.discount != 0
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                                if (itemModel.discount != 0)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      getPriceAndCurrency(
                                          itemModel.priceAfterDiscount!),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
