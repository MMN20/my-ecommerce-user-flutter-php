import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/notifications_data.dart';
import 'package:my_eccommerce_user/data/model/notofications_model.dart';

class NotificationsPageController extends GetxController {
  List<NotificationsModel> notifs = [];
  RequestStatus requestStatus = RequestStatus.none;
  ScrollController scrollController = ScrollController();
  int maxNotifs = 1000;
  bool showGetMoreContentLoading = false;

  void getMoreNotifs() async {
    if (scrollController.position.maxScrollExtent - 150 <=
            scrollController.position.pixels &&
        maxNotifs > notifs.length &&
        !showGetMoreContentLoading) {
      showGetMoreContentLoading = true;
      getAllNotifs(false);
    }
  }

  Future<void> getAllNotifs([bool showLoadingStatus = true]) async {
    int currentIndex = notifs.isEmpty ? 0 : notifs.last.notificationsId!;
    if (showLoadingStatus) {
      requestStatus = RequestStatus.loading;
    }
    update();
    dynamic response =
        await NotificationsData.getAllNotifications(currentIndex.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        maxNotifs = response['maxCount'];
        List responseData = response['data'];
        notifs.addAll(
            responseData.map((e) => NotificationsModel.fromJson(e)).toList());
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    showGetMoreContentLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllNotifs();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(getMoreNotifs);
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
