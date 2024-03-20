import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/SalesOrder.dart';
import '../../ModelClass/loginmodel.dart';

class OrderController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  B2cLoginModel? b2cLoginModel;

  Rx<List<SalesOrder>?> ordersModelList = (null as List<SalesOrder>?).obs;

  Rx<List<SalesOrder>?> ordersDetailList = (null as List<SalesOrder>?).obs;

  getOrderList() async {
    isLoading.value = true;
    b2cLoginModel = await PreferenceHelper.getUserData();
    NetworkManager.get(url: HttpUrl.b2cCustomerOrderListing, parameters: {
      "searchModel.organisationId": "${HttpUrl.org}",
      "searchModel.customerCode": b2cLoginModel?.b2CCustomerId,
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<SalesOrder> list = resJson.map<SalesOrder>((value) {
              return SalesOrder.fromJson(value);
            }).toList();
            ordersModelList.value = list;
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          PreferenceHelper.getShowSnackBar(
              msg: response.apiResponseModel!.message ?? "");
        }
      } else {
        change(null, status: RxStatus.error());
        // PreferenceHelper.getShowSnackBar(
        //     // msg: response.apiResponseModel!.message ?? "");
        //     msg: "Your Order List is Empty" ?? "");
      }
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(msg: error.toString() ?? "");
      },
    );
  }

  getOrderDetails(String? orderNo) async {
    isLoading.value = true;
    NetworkManager.get(url: HttpUrl.customerOrderGetByCode, parameters: {
      "OrganizationId": "${HttpUrl.org}",
      "OrderNo": orderNo,
    }).then((response) {
      isLoading.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        change(null, status: RxStatus.success());
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            ordersDetailList.value = (response.apiResponseModel!.data as List)
                .map((e) => SalesOrder.fromJson(e))
                .toList();
            // List<SalesOrder> list = resJson.map<SalesOrder>((value) {
            //   return SalesOrder.fromJson(value);
            // }).toList();
            // ordersDetailList.value = list;
            print("<<<<<<<<<${ordersDetailList.value?.length}");
            change(null, status: RxStatus.success());
            return;
          }
        } else {
          change(null, status: RxStatus.error());
          PreferenceHelper.getShowSnackBar(
              msg: response.apiResponseModel!.message ?? "");
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(
            msg: response.apiResponseModel!.message ?? "");
      }
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(msg: error.toString() ?? "");
      },
    );
  }
}
