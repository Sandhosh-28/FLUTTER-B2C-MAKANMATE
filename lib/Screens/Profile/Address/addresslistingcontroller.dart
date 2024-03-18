import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Const/fonts.dart';
import '../../../Helper/api.dart';
import '../../../Helper/networkclass.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/addressmodel.dart';
import '../../../ModelClass/loginmodel.dart';

class AddressListingController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController addressLine3Controller = TextEditingController();
  TextEditingController unitNoController = TextEditingController();
  TextEditingController floorNoController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isSelected = false.obs;

  Rx<List<AddressModel>?> addressList = (null as List<AddressModel>?).obs;
  B2cLoginModel? loginUser;

  final addAddressKey = GlobalKey<FormState>();

  AddressModel? addNewAddress;

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

  postAddress() async {
    change(null, status: RxStatus.loading());
    await NetworkManager.post(
            URl: HttpUrl.addNewAddress, params: addNewAddress?.toJson())
        .then((apiResponse) async {
      if (apiResponse.apiResponseModel != null &&
          apiResponse.apiResponseModel!.status) {
        // PreferenceHelper.getShowSnackBar(msg: "Address Successfully Added");
        // if (iscart == false) {
        //   Get.offAllNamed(AppRoutes.addressScreen);
        // }
        // if (iscart == true) {
        //   Get.offAllNamed(AppRoutes.cartScreen);
        // }
        showPopup();
        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error());
        PreferenceHelper.getShowSnackBar(msg: apiResponse.error);
      }
    });
  }

  showPopup() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          backgroundColor: MyColors.lightGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            "Address Created \nSuccessfully",
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              color: MyColors.black,
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
      Get.offAllNamed(Routes.userBottomNavBar);
    });
  }
}
