import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/items_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/categories_list.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/items_list.dart';
import 'package:my_eccommerce_user/view/widgets/items_page/my_drawer.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ItemsPageController());
    return Scaffold(
      drawer: GetBuilder(
          init: controller,
          builder: (context) {
            return MyDrawer(
              controller: controller,
            );
          }),
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Search",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          controller: controller.searchController,
          onChanged: controller.onSearchTextChange,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: SizedBox(
            height: 50,
            child: GetBuilder(
              init: controller,
              builder: (controller) {
                return CategoriesList(
                  controller: controller,
                );
              },
            ),
          ),
        ),
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: ItemsList(
                controller: controller,
              ),
            );
          }),
    );
  }
}
