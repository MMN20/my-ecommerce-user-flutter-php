import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/settings/addresses/add_address_page_controller.dart';
import 'package:my_eccommerce_user/core/functions/validator.dart';
import 'package:my_eccommerce_user/view/widgets/general_button.dart';
import 'package:my_eccommerce_user/view/widgets/my_text_form_field.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressesPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add an address"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return RequestStatusView(
              onErrorTap: () {},
              requestStatus: controller.requestStatus,
              child: Form(
                key: controller.formState,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        labelText: "Address name",
                        icon: const Icon(Icons.location_on),
                        controller: controller.nameController,
                        hintText: "Address name",
                        validator: (text) {
                          return validator(
                            text!,
                            2,
                            200,
                            "The name is too short",
                            "The name is too long",
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Address description",
                        icon: const Icon(Icons.location_on),
                        controller: controller.descController,
                        hintText: "Address description",
                        validator: (text) {
                          return validator(
                            text!,
                            2,
                            200,
                            "The description is too short",
                            "The description is too long",
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      GeneralButton(
                        onPressed: () {
                          controller.addAddress();
                        },
                        child: const Text("Save"),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
