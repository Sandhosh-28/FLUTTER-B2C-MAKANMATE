import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../../Helper/api.dart';
import '../../Helper/networkclass.dart';
import '../../Helper/preferencehelper.dart';

class NewPasswordController extends GetxController with StateMixin {
  ///NEW PASSWORD SCREEN
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final newPassKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  String? email;
  @override
  void onInit() {
    super.onInit();
    email = Get.arguments as String;
  }

  forgotPasswordChange() async {
    isLoading.value = true;
    update();
    NetworkManager.post(
      URl: HttpUrl.changePassword,
      params: {
        "OrgId": HttpUrl.org,
        "B2CCustomerId": "",
        "EmailId": email,
        "Password": confirmPasswordController.text,
      },
    ).then((apiResponse) async {
      isLoading.value = false;
      change(null, status: RxStatus.success());
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        if (apiResponse.apiResponseModel!.status) {
          await PreferenceHelper.clearUserData();
          await PreferenceHelper.savePassword(
              key: "Password", value: confirmPasswordController.text);
          forgotPassShowPopup();
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

  forgotPassShowPopup() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            "Password Updated \nSuccessfully",
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

// forgotPasswordChange() async {
//   isLoading.value = false;
//   change(null, status: RxStatus.loading());
//   NetworkManager.post(URl: HttpUrl.forgotPasswordApi, params: {
//     "OrganisationId": 1,
//     "Email": email,
//     "user": confirmPasswordController.text,
//   }).then((apiResponse) async {
//     isLoading.value = false;
//     if (apiResponse.apiResponseModel != null &&
//         apiResponse.apiResponseModel!.status) {
//       if (apiResponse.apiResponseModel!.data != null &&
//           (apiResponse.apiResponseModel!.data as List).isNotEmpty) {
//         Get.offAllNamed(Routes.loginScreen);
//         change(null, status: RxStatus.success());
//         Map<String, dynamic>? customerJson =
//             (apiResponse.apiResponseModel!.data! as List).first;
//         if (customerJson != null) {
//           await PreferenceHelper.clearUserData();
//           await PreferenceHelper.saveUserData(customerJson)
//               .then((value) async {
//             Get.offAllNamed(Routes.bottomNavBar)?.then((value) {
//               email = "";
//               confirmPasswordController.text = "";
//             });
//           });
//           await PreferenceHelper.saveEmail(key: "my_key", value: email!);
//           await PreferenceHelper.savePassword(
//               key: "Password", value: confirmPasswordController.text);
//         } else {
//           change(null, status: RxStatus.error());
//           PreferenceHelper.getShowSnackBar(msg: "Customer Data is Empty");
//         }
//       }
//     } else {
//       change(null, status: RxStatus.error());
//       String? message = apiResponse.apiResponseModel?.message.toString();
//       print("API Response Message (Error): $message");
//       PreferenceHelper.getShowSnackBar(context: Get.context, msg: "Error");
//     }
//   });
// }
}
