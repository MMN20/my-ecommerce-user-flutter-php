import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/api_links.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/model/category_model.dart';
import 'package:my_eccommerce_user/view/screens/items_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});
  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    return InkWell(
      onTap: () {
        controller.goToItemsPage(categoryModel.catId!);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          color: AppColors.thirdColor10,
          elevation: 10,
          margin: const EdgeInsets.only(right: 8),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Center(
                        child: SvgPicture.network(
                          "${APILinks.categoryImages}/${categoryModel.catImageUrl}",
                          height: 60,
                          fit: BoxFit.fill,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  categoryModel.catName!,
                  style: const TextStyle(
                      color: AppColors.mainColor60, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
