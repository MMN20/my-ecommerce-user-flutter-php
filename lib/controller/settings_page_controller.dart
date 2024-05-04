import 'package:get/get.dart';
import 'package:my_eccommerce_user/routes.dart';

class SettingsPageController extends GetxController {
  void goToAddressesPage() {
    Get.toNamed(AppRoutes.addresses);
  }

  void goToOrdersPage() {
    Get.toNamed(AppRoutes.ordersPage);
  }

  void goToArchivedOrdersPage() {
    Get.toNamed(AppRoutes.archivedOrders);
  }
}
