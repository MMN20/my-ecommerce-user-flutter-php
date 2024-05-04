import 'package:get/get.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/home_page_data.dart';
import 'package:my_eccommerce_user/data/model/category_model.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/data/model/promotion_model.dart';
import 'package:my_eccommerce_user/routes.dart';

class HomePageController extends GetxController {
  int currentPromotionIndex = 0;
  void changeCurrentPromotionPage(int index) {
    currentPromotionIndex = index;
    update();
  }

  void removeRequestError() {
    requestStatus = RequestStatus.none;
    update();
  }

  RequestStatus requestStatus = RequestStatus.none;

  List<CategoryModel> categories = [];
  List<PromotionModel> promotions = [];
  List<ItemModel> offers = [];

  void goToItemsPage(int categoryID) {
    Get.toNamed(AppRoutes.items,
        arguments: {'catid': categoryID, 'categories': categories});
  }

  Future<void> getAllData() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await HomePageData.homePageData();

    requestStatus = hanldeRequestData(response);

    if (requestStatus == RequestStatus.success) {
      List responseData = response['promotions'];
      promotions = responseData.map((e) => PromotionModel.fromJson(e)).toList();

      responseData = response['categories'];
      categories = responseData.map((e) => CategoryModel.fromJson(e)).toList();

      responseData = response['offers'];
      offers = responseData.map((e) => ItemModel.fromJson(e)).toList();
    }

    update();
  }

  void likeUnlike(ItemModel item) {
    item.likeUnlike();
    update();
  }

  void goToFavoritePage() {
    Get.toNamed(AppRoutes.favoritePage);
  }

  void goToItemDetailsPage(ItemModel item) {
    Get.toNamed(AppRoutes.itemDetails, arguments: {"item": item});
  }

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }
}
