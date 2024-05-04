import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_eccommerce_user/controller/home_page_controller.dart';
import 'package:my_eccommerce_user/core/functions/handle_request_data.dart';
import 'package:my_eccommerce_user/core/request_status.dart';
import 'package:my_eccommerce_user/data/data_source/remote/items_page_data.dart';
import 'package:my_eccommerce_user/data/model/category_model.dart';
import 'package:my_eccommerce_user/data/model/item_model.dart';
import 'package:my_eccommerce_user/data/model/user.dart';
import 'package:my_eccommerce_user/routes.dart';

class ItemsPageController extends GetxController {
  late List<CategoryModel> categories;
  List<CategoryModel> subCategories = [];
  List<ItemModel> items = [];
  List<ItemModel> searchedItems = [];
  late int currentCatID;
  String selectedSubCats = "all";
  bool fetchedSubCats = false;
  bool showSearchedItems = false;
  TextEditingController searchController = TextEditingController();
  bool _isSearchLoading = false;

  void onSearchTextChange(String s) {
    if (s.isEmpty) {
      showSearchedItems = false;
    } else {
      showSearchedItems = true;
      getSearchedItems(s);
    }
    update();
  }

  Future<void> getSearchedItems(String word) async {
    if (items.length != 0) {
      update();
      dynamic response = await ItemsData.getSearchedItems(
          currentCatID.toString(), UserModel.currentUser!.id.toString(), word);
      requestStatus = hanldeRequestData(response);
      if (requestStatus == RequestStatus.success) {
        List responseData;
        if (!fetchedSubCats) {
          responseData = response['data']['subCategories'];

          subCategories = responseData
              .map((e) => CategoryModel.subCategoryFromJson(e))
              .toList();
          fetchedSubCats = true;
        }
        responseData = response['data']['items'];

        searchedItems = responseData.map((e) => ItemModel.fromJson(e)).toList();
      }
      update();
    }
  }

  void changeSubCatSelectedState(CategoryModel subCat) {
    subCat.isSelected = !subCat.isSelected;
    update();
    setSelectedSubCats();
  }

  void setSelectedSubCats() {
    String selected = "";
    for (var element in subCategories) {
      if (element.isSelected) {
        selected += element.catId.toString() + ",";
      }
    }

    selected = selected.substring(0, selected.length - 1);
    selectedSubCats = selected;
  }

  void getNewResult() {
    getAllCategories(currentCatID.toString());
  }

  void changeCurrentCatID(int catID) {
    if (catID != currentCatID) {
      currentCatID = catID;
      selectedSubCats = 'all';
      fetchedSubCats = false;
      update();
      getAllCategories(catID.toString());
    }
  }

  RequestStatus requestStatus = RequestStatus.none;

  Future<void> getAllCategories(String catid) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await ItemsData.getItems(
        catid, selectedSubCats, UserModel.currentUser!.id.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      List responseData;
      if (!fetchedSubCats) {
        responseData = response['data']['subCategories'];

        subCategories = responseData
            .map((e) => CategoryModel.subCategoryFromJson(e))
            .toList();
        fetchedSubCats = true;
      }
      responseData = response['data']['items'];

      items = responseData.map((e) => ItemModel.fromJson(e)).toList();
    }
    update();
  }

  @override
  void onInit() {
    currentCatID = Get.arguments['catid'];
    categories = Get.arguments['categories'];
    getAllCategories(currentCatID.toString());
    super.onInit();
  }

  void likeUnlike(ItemModel item) {
    item.likeUnlike();
    update();
    refreshHomePageOffers(item);
  }

  Future<void> addToCart(ItemModel item) async {
    item.cartAmount = 1;
    update();
    await item.addToCart();
  }

  Future<void> onDeleteFromCart(ItemModel item) async {
    item.cartAmount = 0;
    update();
    await item.deleteFromCart();
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

  void goToItemDetailsPage(ItemModel item) {
    Get.toNamed(AppRoutes.itemDetails,
        arguments: {"item": item, "isItemsPage": true});
  }

  // void initValues(
  //     {required int catid, required List<CategoryModel> categories}) {
  //   currentCatID = catid;
  //   this.categories = categories;
  //   getAllCategories(currentCatID.toString());
  // }
}
