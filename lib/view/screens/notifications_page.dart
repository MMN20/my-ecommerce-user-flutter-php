import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/notifications_page_controller.dart';
import 'package:my_eccommerce_user/data/model/notofications_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("======================== NotificationsPage");
    final controller = Get.put(NotificationsPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.notifications_none_rounded),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.notifs.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                NotificationsModel notif = controller.notifs[index];
                return Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(notif.notificationsTitle!),
                        subtitle: Text(notif.notificationsBody!),
                      ),
                    ),
                    if (controller.showGetMoreContentLoading &&
                        index + 1 == controller.notifs.length)
                      const Center(child: CircularProgressIndicator()),
                    if (index + 1 == controller.notifs.length)
                      const SizedBox(height: 70),
                  ],
                );
              },
            );
          }),
    );
  }
}
