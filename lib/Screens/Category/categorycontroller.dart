import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/categorymodel.dart';

class CategoryListController extends GetxController with StateMixin {
  RxBool isLoadings = false.obs;

  Rx<List<CategoryModel>?> categoryList = (null as List<CategoryModel>?).obs;

  getAllCategoryList() async {
    change(null, status: RxStatus.loading());
    isLoadings.value = true;
    await NetworkManager.get(
        url: HttpUrl.getAllCategory,
        parameters: {"OrganizationId": HttpUrl.org}).then((response) {
      isLoadings.value = false;
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            List<CategoryModel> list = resJson.map<CategoryModel>((value) {
              return CategoryModel.fromJson(value);
            }).toList();
            categoryList.value = list;
            change(null, status: RxStatus.success());
          }
        } else {
          change(null, status: RxStatus.error());
          PreferenceHelper.getShowSnackBar(
              context: Get.context!,
              msg: response.apiResponseModel?.message ?? '');
        }
      }
    }).catchError(
      (error) {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(
            context: Get.context!, msg: error.toString());
      },
    );
  }
}
