import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/model/order_model.dart';

class OrderTrackingPageController extends GetxController {
  Set<Marker> markers = {};
  late OrderModel orderModel;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? subscription;
  GoogleMapController? gmc;
  LatLng? deliveryLocation;
  CameraPosition? cameraPosition;
  bool isLoading = true;
  bool isThereData = false;

  void refreshCameraPosition() {
    if (gmc != null) {
      gmc!.animateCamera(CameraUpdate.newLatLng(deliveryLocation!));
    }
  }

  void listenToDerliveryLocation() async {
    var doc = await FirebaseFirestore.instance
        .collection("delivery")
        .doc(orderModel.ordersId.toString())
        .get();
    if (doc.exists) {
      deliveryLocation = LatLng(doc['lat'], doc['long']);
      cameraPosition = CameraPosition(target: deliveryLocation!, zoom: 14.7);
      markers.add(
        Marker(
          markerId: const MarkerId("1"),
          position: deliveryLocation!,
        ),
      );
      isThereData = true;
      subscription = FirebaseFirestore.instance
          .collection("delivery")
          .doc(orderModel.ordersId.toString())
          .snapshots()
          .listen((event) {
        deliveryLocation = LatLng(event['lat'], event['long']);
        refreshCameraPosition();
        markers.add(
          Marker(
            markerId: const MarkerId("1"),
            position: deliveryLocation!,
          ),
        );
      });
    }

    isLoading = false;
    update();
  }

  void initData() {
    orderModel = Get.arguments["orderModel"];
    listenToDerliveryLocation();
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }
}
