import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/SalesOrder.dart';
import '../../ModelClass/productmodel.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class PlaceOrderController extends GetxController with StateMixin {
  final CartService cartService = getIt<CartService>();

  List<ProductModel> selectedItems = [];

  RxBool isLoading = false.obs;

  late SalesOrder salesOrder;

  salesOrderApi() async {
    isLoading.value = true;
    int index = 1;
    salesOrder.orderDetail?.forEach((element) {
      element.slNo = index;
      index += 1;
    });
    NetworkManager.post(
            URl: HttpUrl.salesOrderCreate, params: salesOrder.toJson())
        .then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          selectedItems.clear();
          cartService.cartItems.clear();
          await PreferenceHelper.removeCartData();
          showPopup();
          Timer(const Duration(seconds: 10), () async {
            cartService.clearCart();
            await PreferenceHelper.removeCartData()
                .then((value) => Get.offAllNamed(Routes.userBottomNavBar));
          });
        } else {
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.getShowSnackBar(context: Get.context!, msg: message);
        }
      } else {
        PreferenceHelper.getShowSnackBar(
            context: Get.context!, msg: apiResponse.error);
      }
    });
  }

  showPopup() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text(
            "Your Order Placed \nSuccessfully",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.black,
            ),
          ),
          content: const Text(
            "You Order Placed successfully. You will get your food within 25 minutes. Thanks for using our services. Enjoy your food :)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyColors.textGrey,
            ),
          ),
          actions: [
            ButtonBar(alignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {},
                child: const Text("Keep Browsing"),
              ),
            ]),
          ],
          icon: SizedBox(
            height: 150.0,
            child: Image.asset(
              Assets.successfully,
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.userBottomNavBar);
    });
  }

  void updateProductCount() {
    for (var product in selectedItems) {
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
}
