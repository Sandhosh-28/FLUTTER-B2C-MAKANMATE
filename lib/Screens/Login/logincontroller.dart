import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/colors.dart';
import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferencehelper.dart';

class LoginController extends GetxController with StateMixin {
  RxBool isVis = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final loginKey = GlobalKey<FormState>();

  String? messages;

  onLoginTapped() async {
    isLoading.value = false;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.login, params: {
      "OrgId": HttpUrl.org,
      "Username": emailController.text.trim(),
      "Password": passwordController.text.trim(),
      "BranchCode": "HO"
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
            await PreferenceHelper.saveUserData(customerJson)
                .then((value) async {
              Get.offAllNamed(Routes.userBottomNavBar);
            });
            await PreferenceHelper.saveEmail(
                key: "my_key", value: emailController.text);
            await PreferenceHelper.savePassword(
                key: "Password", value: passwordController.text);
          } else {
            change(null, status: RxStatus.error());
            PreferenceHelper.getShowSnackBar(msg: "Customer Data is Empty");
          }
        }
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        message = messages;
        print("API Response Message (Error): $message");
        PreferenceHelper.getShowSnackBar(
            context: Get.context,
            msg: "Your Username or Password are Incorrect");
      }
    });
  }
}
