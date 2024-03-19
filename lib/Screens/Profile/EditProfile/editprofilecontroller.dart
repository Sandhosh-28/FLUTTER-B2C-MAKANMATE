import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/B2cCustomerEditModel.dart';

class EditProfileController extends GetxController with StateMixin {
  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final updateProfileKey = GlobalKey<FormState>();

  late B2cCustomerEditModel b2cCustomerEditModel;

  updateProfile(String? b2cCustomerId) async {
    print("Enter........Enter");
    isLoading.value = true;
    NetworkManager.post(URl: HttpUrl.editProfile, params: {
      "orgId": HttpUrl.org,
      "b2CCustomerId": b2cCustomerId,
      "b2CCustomerName": nameController.text,
      "addressLine1": "",
      "addressLine2": "",
      "addressLine3": "",
      "countryId": "",
      "postalCode": "",
      "mobileNo": phoneController.text,
      "changedBy": "Admin",
      "changedOn": "2024-01-25T07:31:24.101Z",
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

  showPopup() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text(
            "Profile Updated \nSuccessfully",
            style: TextStyle(
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
