import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/productmodel.dart';
import '../../../locator/cart_service.dart';
import '../../../locator/locator.dart';

class FeaturedDetailsController extends GetxController with StateMixin {
  String? topChoiceRadio;
  String? bottomChoiceRadio;

  RxBool isAddClick = true.obs;
  RxBool isLoading = false.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> cartAddedProduct = <ProductModel>[].obs;

  RxList<ProductModel> mateAddedProduct = <ProductModel>[].obs;

  final CartService cartService = getIt<CartService>();

  List<ProductModel> allmostPopularBookList = [];
  List<ProductModel> mostPopularBookList = [];
  // List<ProductModel> martPopularBookList = [];

  List<ProductModel> allfeaturedItemList = [];
  List<ProductModel> featuredItemList = [];

  ///PRODUCT GET BY CODE
  Future<void> productGetByCode(String? productCode, bool? isMate) async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    await NetworkManager.get(
      url: HttpUrl.productGetByCode,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "ProductCode": productCode,
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<ProductModel> list;
            list = resJson.map<ProductModel>((value) {
              return ProductModel.fromJson(value);
            }).toList();
            productList.value = list;
            if (isMate == true) {
              updateProductCount();
            }
            if (isMate == false) {
              updateProductCount1();
            }
            change(null, status: RxStatus.success());
          } else {
            print("productList.length");
            print(productList.length);
            change(null, status: RxStatus.error());
          }
        } else {
          change(null, status: RxStatus.error());
          String? message = response.apiResponseModel?.message;
          PreferenceHelper.getShowSnackBar(context: Get.context!, msg: message);
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      String? message = error.toString();
      Get.showSnackbar(PreferenceHelper.getShowSnackBar(
          context: Get.context!, msg: message));
    });
  }

  Future<void> updateProductCount() async {
    for (var product in productList) {
      cartService.cartItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.qtyCount = element.qtyCount;
          return true;
        } else {
          return false;
        }
      });
    }
  }

  Future<void> updateProductCount1() async {
    for (var product in productList) {
      cartService.martItems.firstWhereOrNull((element) {
        if (element.productCode == product.productCode) {
          product.qtyCount = element.qtyCount;
          return true;
        } else {
          return false;
        }
      });
    }
  }

}
