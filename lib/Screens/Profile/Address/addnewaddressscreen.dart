import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/size.dart';

import '../../../Const/approute.dart';
import '../../../Helper/api.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/addressmodel.dart';
import '../../Widget/submitbutton.dart';
import '../../Widget/textformfield.dart';
import 'addresslistingcontroller.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late AddressListingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    controller = Get.put(AddressListingController());
  }

  getUserData() async {
    await PreferenceHelper.getUserData().then((value) {
      customerId = value?.b2CCustomerId;
      b2CCustomerName = value?.b2CCustomerName;
      brachCode = value?.branchCode;
      emailId = value?.emailId;
      emailId = value?.mobileNo;
      postalCode = value?.postalCode;
      address = value?.addressLine1.toString();
      countryId = value?.countryId;
      orgId = value?.orgId.toString();
    });
  }

  ///GET CUSTOMER DATA
  String? customerId;
  String? orgId;
  String? countryId;
  String? address;
  String? postalCode;
  String? emailId;
  String? mobileNo;
  String? b2CCustomerName;
  String? brachCode;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addAddressKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text("Add Address"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.nameController,
                inputFormatters: [],
                hintText: "Location Type",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Unit No",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: controller.unitNoController,
                          inputFormatters: [],
                          hintText: "Unit No",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width(context) / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Floor No",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        CustomTextFormField(
                          controller: controller.floorNoController,
                          inputFormatters: [],
                          hintText: "Floor No",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Address Line 1",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.addressLine1Controller,
                inputFormatters: [],
                hintText: "Address",
              ),
              const SizedBox(height: 20),
              const Text(
                "Address Line 2",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.addressLine2Controller,
                inputFormatters: [],
                hintText: "Address",
              ),
              const SizedBox(height: 20),
              const Text(
                "Address Line 3",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.addressLine3Controller,
                inputFormatters: [],
                hintText: "Address",
              ),
              const SizedBox(height: 20),
              const Text(
                "Postal Code",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.postalCodeController,
                inputFormatters: [],
                hintText: "Postal Code",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
            isLoading: false,
            onTap: () async {
              if (controller.addAddressKey.currentState!.validate()) {
                print("Success");

                controller.addNewAddress = AddressModel(
                  orgId: HttpUrl.org,
                  customerId: customerId ?? "",
                  deliveryId: 1,
                  fax: "",
                  isDefault: true,
                  mobile: mobileNo ?? "",
                  name: controller.nameController.text,
                  phone: mobileNo ?? "",
                  addressLine1: controller.addressLine1Controller.text,
                  addressLine2: controller.addressLine2Controller.text,
                  addressLine3: controller.addressLine3Controller.text,
                  floorNo: controller.floorNoController.text,
                  unitNo: controller.unitNoController.text,
                  countryId: "",
                  postalCode: controller.postalCodeController.text,
                  isActive: controller.addNewAddress?.isActive ?? true,
                  createdBy: "Admin",
                  createdOn: "2024-02-09T05:19:15.162Z",
                  changedBy: b2CCustomerName ?? "",
                  changedOn: "2024-02-09T05:19:15.162Z",
                );
                await controller.postAddress();
                // get.clear();
              }
            },
            title: "Add New Address",
          ),
        ),
      ),
    );
  }
}
