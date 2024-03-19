import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferencehelper.dart';

class ForgotPasswordController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();

  final pinController = TextEditingController();

  final forgotPassKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  RxBool sendOtpLoading = false.obs;

  RxBool isVerify = false.obs;

  String? otpValue;

  String? otp;

  exitingEmailCheck() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.exitingEmailRegister, parameters: {
      "OrganizationId": "${HttpUrl.org}",
      "EmailId": emailController.text
    }).then((response) {
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            if (response.apiResponseModel!.data![0]['B2CCustomerId'] == null) {
              isLoading.value = false;
              change(null, status: RxStatus.success());
              PreferenceHelper.getShowSnackBar(msg: "User doesn't Exist");
            } else {
              sendOTP(true);
            }
            return;
          }
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: error.toString(),
          icon: const Icon(Icons.error),
          duration: const Duration(seconds: 3),
        ),
      );
    });
  }

  sendOTP(bool isResend) async {
    sendOtpLoading.value = true;
    final String url =
        "${HttpUrl.base}/SendOTP/SendOTP?OrganizationId=${HttpUrl.org}&Email=${emailController.text}";
    final response = await http.post(Uri.parse(url));
    sendOtpLoading.value = false;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      otpValue = data['Data'];
      print('POST request successful${otpValue}');
      print('Response data: ${data['Data']}');

      if (isResend) {
        sendOtpLoading.value = false;
        Get.toNamed(Routes.forgotPasswordOTPScreen);
      }
      // You can parse and handle the response here
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      // Handle errors and error responses here
    }
  }

  verifyOtp(BuildContext context) async {
    isVerify.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.post(URl: HttpUrl.verifyOtp, params: {
      "OrgId": HttpUrl.org,
      "Email": emailController.text,
      "OTP": otp,
    }).then((apiResponse) async {
      isVerify.value = false;
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        isVerify.value = true;
        Get.toNamed(Routes.newPasswordScreen, arguments: emailController.text);
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        PreferenceHelper.getShowSnackBar(msg: message);
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
            "Email Verified \nSuccessfully",
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
      Get.toNamed(Routes.newPasswordScreen, arguments: emailController.text);
    });
  }
}
