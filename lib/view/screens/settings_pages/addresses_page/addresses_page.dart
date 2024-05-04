import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/settings/addresses/addresses_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Addresses"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddAddressPage();
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return RequestStatusView(
            onErrorTap: () {},
            requestStatus: controller.requestStatus,
            child: ListView.builder(
              itemCount: controller.addresses.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(controller.addresses[index].addressesName!),
                    subtitle: Text(controller.addresses[index].addressesDesc!),
                    trailing: IconButton(
                      onPressed: () {
                        controller.deleteAnAddress(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
