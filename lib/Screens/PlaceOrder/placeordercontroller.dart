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
import '../../ModelClass/addressmodel.dart';
import '../../ModelClass/loginmodel.dart';
import '../../ModelClass/productmodel.dart';
import '../../locator/cart_service.dart';
import '../../locator/locator.dart';

class PlaceOrderController extends GetxController with StateMixin {
  final CartService cartService = getIt<CartService>();

  List<ProductModel> selectedItems = [];

  List<AddressModel> selectedAddress = [];

  RxBool isLoading = false.obs;

  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;

  late SalesOrder salesOrder;

  B2cLoginModel? loginUser;

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
                .then((value) => Get.offAll(Routes.userBottomNavBar));
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

  Future<void> updateProductCount1() async {
    for (var product in selectedItems) {
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

  getAddress() async {
    isLoading.value = true;
    loginUser = await PreferenceHelper.getUserData();
    await NetworkManager.get(
      url: HttpUrl.b2CCustomerDeliveryAddressGetAll,
      parameters: {
        "OrganizationId": HttpUrl.org,
        "CustomerId": loginUser?.b2CCustomerId
      },
    ).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            addressList.value = (response.apiResponseModel!.data as List)
                .map((e) => AddressModel.fromJson(e))
                .toList();
            change(addressList.value);
          }
          change(null, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error());
          PreferenceHelper.getShowSnackBar(
            msg: response.apiResponseModel?.message,
          );
        }
      } else {
        addressList.value?.length = 0;
        change(null, status: RxStatus.success());
        print("addressList.value?.length");
        print(addressList.value?.length);
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        PreferenceHelper.getShowSnackBar(
          msg: error.toString(),
        ),
      );
    });
    print("addressList.value?.length");
    print(addressList.value?.length);
  }
}
