import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/settings_page_controller.dart';
import 'package:my_eccommerce_user/core/utils/colors.dart';
import 'package:my_eccommerce_user/view/widgets/settings_page/settings_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("===================== SettingsPage");
    final controller = Get.put(SettingsPageController());
    const Color dividerColor = Colors.grey;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            // color: Colors.red,
            height: Get.height * 0.35,
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight * 0.5,
                  color: AppColors.thirdColor10,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SettingsItem(
                  onTap: () {
                    controller.goToOrdersPage();
                  },
                  name: "Orders",
                  icon: const Icon(Icons.fire_truck),
                ),
                const Divider(
                  color: dividerColor,
                  height: 1,
                ),
                SettingsItem(
                  onTap: () {
                    controller.goToArchivedOrdersPage();
                  },
                  name: "Archived orders",
                  icon: const Icon(Icons.archive),
                ),
                const Divider(
                  color: dividerColor,
                  height: 1,
                ),
                SettingsItem(
                  onTap: () {
                    controller.goToAddressesPage();
                  },
                  name: "Address",
                  icon: const Icon(Icons.location_on),
                ),
                const Divider(
                  color: dividerColor,
                  height: 1,
                ),
                SettingsItem(
                  onTap: () {},
                  name: "About us",
                  icon: const Icon(Icons.info),
                ),
                const Divider(
                  color: dividerColor,
                  height: 1,
                ),
                SettingsItem(
                  onTap: () {},
                  name: "Contact us",
                  icon: const Icon(Icons.call),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }
}
