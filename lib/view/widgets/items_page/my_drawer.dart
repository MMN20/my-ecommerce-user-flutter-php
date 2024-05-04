import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/data/model/category_model.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.controller});
  final ItemsPageController controller;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * 0.5,
      child: SafeArea(
        child: Column(
          children: [
            GeneralButton(
                onPressed: () {
                  controller.getNewResult();
                },
                child: const Text("Get")),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: controller.subCategories.length,
                itemBuilder: (context, index) {
                  CategoryModel categoryModel = controller.subCategories[index];
                  return Center(
                    child: ListTile(
                      title: Text(controller.subCategories[index].catName!),
                      trailing: Checkbox(
                        value: categoryModel.isSelected,
                        onChanged: (val) {
                          controller.changeSubCatSelectedState(categoryModel);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
