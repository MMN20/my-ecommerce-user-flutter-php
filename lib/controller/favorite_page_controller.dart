import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/favorite_data.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/routes.dart';

class FavoritePageController extends GetxController {
  List<ItemModel> items = [];
  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllItems() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await FavoriteData.getFavoriteItems();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      List responseData = response['data'];
      items.addAll(responseData.map((e) => ItemModel.fromJson(e)));
    }
    update();
  }

  void goToItemDetailsPage(ItemModel item) {
    Get.toNamed(AppRoutes.itemDetails, arguments: {"item": item});
  }

  void likeUnlike(ItemModel item) {
    item.likeUnlike();
    update();
    refreshHomePageOffers(item);
  }

  void refreshHomePageOffers(ItemModel itemModel) {
    final controller = Get.find<HomePageController>();
    for (var item in controller.offers) {
      if (item.itemsId == itemModel.itemsId) {
        item.isFavorite = itemModel.isFavorite;
        break;
      }
    }
    controller.update();
  }

  @override
  void onInit() {
    getAllItems();
    super.onInit();
  }
}
