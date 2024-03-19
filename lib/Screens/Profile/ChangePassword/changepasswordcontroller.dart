import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/fonts.dart';
import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/loginmodel.dart';

class ChangePasswordController extends GetxController with StateMixin {
  RxBool isCurrentPassVis = false.obs;
  RxBool isNewPassVis = false.obs;
  RxBool isConPassVis = false.obs;

  RxBool isLoading = false.obs;

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final changePassKey = GlobalKey<FormState>();

  B2cLoginModel? b2cLoginModel;

  void getUserData() async {
    b2cLoginModel = await PreferenceHelper.getUserData();
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  checkCurrentPassword() async {
    isLoading.value = false;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.login, params: {
      "OrgId": HttpUrl.org,
      "BranchCode": "HO",
      "Username": b2cLoginModel?.emailId,
      "Password": currentPassword.text,
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.data != null &&
            (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
          Get.offAllNamed(Routes.userBottomNavBar);
          change(null, status: RxStatus.success());
          Map<String, dynamic>? customerJson =
              (apiResponse.apiResponseModel!.data! as List).first;
          if (customerJson != null) {
            changePassword();
          } else {
            change(null, status: RxStatus.error());
            PreferenceHelper.getShowSnackBar(msg: "Customer Data is Empty");
          }
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        print("API Response Message (Error): $message");
        PreferenceHelper.getShowSnackBar(
            context: Get.context, msg: "Current Password is Incorrect");
      }
    });
  }

  changePassword() async {
    isLoading.value = true;
    update();
    NetworkManager.post(
      URl: HttpUrl.changePassword,
      params: {
        "OrgId": HttpUrl.org,
        "B2CCustomerId": b2cLoginModel?.b2CCustomerId,
        "EmailId": b2cLoginModel?.emailId,
        "Password": confirmPassword.text,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          await PreferenceHelper.clearUserData();
          await PreferenceHelper.savePassword(
              key: "Password", value: confirmPassword.text);
          showPopup();
        } else {
          change(null, status: RxStatus.error());
          String? message = apiResponse.apiResponseModel?.message;
          PreferenceHelper.getShowSnackBar(context: Get.context, msg: message);
        }
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(
            context: Get.context, msg: apiResponse.error);
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
          title: Text(
            "Password Changed \nSuccessfully",
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: SizedBox(
            height: 150.0,
            child: Image.asset(
              Assets.successfully,
              scale: 3,
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.loginScreen);
    });
  }
}
