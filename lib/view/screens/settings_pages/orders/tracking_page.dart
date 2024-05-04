import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_eccommerce_user/controller/settings/orders/order_tracking_page_controller.dart';
import 'package:my_eccommerce_user/view/widgets/request_status_view.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderTrackingPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Tracking"),
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : !controller.isThereData
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "The deliverrer didn't share his location",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : GoogleMap(
                        initialCameraPosition: controller.cameraPosition!,
                        onMapCreated: (gmc) {
                          controller.gmc = gmc;
                        },
                        markers: controller.markers,
                        mapType: MapType.normal,
                      );
          }),
    );
  }
}
