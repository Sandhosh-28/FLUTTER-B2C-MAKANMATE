import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import 'package:http/http.dart' as http;

import '../../Helper/preferencehelper.dart';
import '../../ModelClass/customerregmodel.dart';

class RegistrationController extends GetxController with StateMixin {
  RxBool isVis = false.obs;
  RxBool isLoading = false.obs;

  String? otpValue;
  String? messages;

  RxBool verifyOTP = false.obs;

  final registrationKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController unitNoController = TextEditingController();
  TextEditingController florNoController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  final pinController = TextEditingController();

  RxBool sendOtpLoading = false.obs;
  RxBool isVerify = false.obs;

  B2cCustomerRegModel? b2cCustomerRegModel;

  exitingEmailCheck() async {
    sendOtpLoading.value = true;
    change(null, status: RxStatus.loading());
    NetworkManager.get(url: HttpUrl.exitingEmailRegister, parameters: {
      "OrganizationId": "${HttpUrl.org}",
      "EmailId": emailController.text
    }).then((response) {
      change(null, status: RxStatus.success());
      if (response.apiResponseModel != null &&
          response.apiResponseModel!.status) {
        if (response.apiResponseModel!.data != null) {
          List? resJson = response.apiResponseModel!.data!;
          if (resJson != null) {
            if (response.apiResponseModel!.data![0]['B2CCustomerId'] == null) {
              sendOTP(true);
            } else {
              sendOtpLoading = false.obs;
              PreferenceHelper.getShowSnackBar(
                  context: Get.context!, msg: "Email Already Registered");
            }
            change(null, status: RxStatus.success());
            return;
          }
        }
      }
    }).catchError((error) {
      change(null, status: RxStatus.error());
      Get.showSnackbar(PreferenceHelper.getShowSnackBar(
          context: Get.context!, msg: "Error"));
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
        Get.offAllNamed(Routes.oTPScreen);
      }
      // You can parse and handle the response here
    } else {
      print('POST request failed with status code: ${response.statusCode}');
      print('Response data: ${response.body}');
      // Handle errors and error responses here
    }
  }

  onRegister() async {
    print("Enter........Enter");
    isLoading.value = true;
    NetworkManager.post(URl: HttpUrl.createCustomerRegister, params: {
      "orgId": HttpUrl.org,
      "branchCode": "HO",
      "b2CCustomerId": "",
      "b2CCustomerName": nameController.text,
      "emailId": emailController.text,
      "password": passwordController.text,
      "addressLine1": "",
      "addressLine2": "",
      "addressLine3": "",
      "floorNo": "",
      "unitNo": "",
      "mobileNo": "",
      "countryId": "",
      "postalCode": "",
      "isActive": b2cCustomerRegModel?.isActive ?? true,
      "isApproved": b2cCustomerRegModel?.isApproved ?? true,
      "createdBy": nameController.text,
      "createdOn": "2024-01-25T07:31:24.100Z",
      "changedBy": "Admin",
      "changedOn": "2024-01-25T07:31:24.101Z",
      "orders": [],
      "address": []
    }).then((apiResponse) async {
      isLoading.value = false;
      if (apiResponse.apiResponseModel != null) {
        if (apiResponse.apiResponseModel!.status) {
          print(apiResponse.apiResponseModel!.status);
          showPopup();
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

  verifyOtp(String? otp) async {
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
        verifyOTP.value = true;
        onRegister();
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        String? message = apiResponse.apiResponseModel?.message.toString();
        PreferenceHelper.getShowSnackBar(context: Get.context!, msg: message);
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
            "Your Account Registered \nSuccessfully",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.black,
            ),
          ),
          actions: [
            ButtonBar(alignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {},
                child: const Text("Happy Eating"),
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
      Get.offAllNamed(Routes.loginScreen);
    });
  }
}
