import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/bannermodel.dart';
import '../../ModelClass/categorymodel.dart';

class DashBoardController extends GetxController with StateMixin {
  RxBool isLoadings = false.obs;
  final CarouselController carouselController = CarouselController();

  List<BannerModel> bannerImageList = [];

  int currentIndex = 0;

  bannerGetAll() async {
    await NetworkManager.get(
      url: HttpUrl.banner,
      parameters: {"OrganizationId": HttpUrl.org},
    ).then((apiResponse) async {
      print(apiResponse.apiResponseModel!.result);
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null) {
          bannerImageList = (apiResponse.apiResponseModel!.data as List)
              .map((e) => BannerModel.fromJson(e))
              .toList();
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
}
