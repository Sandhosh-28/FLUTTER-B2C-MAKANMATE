import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/addressmodel.dart';
import '../../../ModelClass/loginmodel.dart';

class AddressListingController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;

  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;
  B2cLoginModel? loginUser;

  getAddress() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
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
            msg: response.apiResponseModel!.message ?? '',
          );
        }
      } else {
        addressList.value?.length = 0;
        change(null, status: RxStatus.success());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      PreferenceHelper.getShowSnackBar(
        msg: error.toString(),
      );
    });
  }
}
