import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/data/model/category_model.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key, required this.controller});
  final ItemsPageController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        CategoryModel categoryModel = controller.categories[index];
        bool isSelected = controller.currentCatID == categoryModel.catId;
        return CategoryItem(
            controller: controller,
            categoryModel: categoryModel,
            isSelected: isSelected);
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.controller,
    required this.categoryModel,
    required this.isSelected,
  });

  final ItemsPageController controller;
  final CategoryModel categoryModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changeCurrentCatID(categoryModel.catId!);
      },
      child: Card(
        margin: const EdgeInsets.only(right: 5, left: 5),
        elevation: isSelected ? 5 : 0,
        color: isSelected ? AppColors.thirdColor10 : AppColors.secondColor30,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.thirdColor10),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoryModel.catName!,
              style: TextStyle(
                  color: isSelected
                      ? AppColors.secondColor30
                      : AppColors.thirdColor10),
            ),
          ),
        ),
      ),
    );
  }
}
