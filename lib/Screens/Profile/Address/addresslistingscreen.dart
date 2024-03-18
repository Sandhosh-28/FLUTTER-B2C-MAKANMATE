import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/fonts.dart';
import '../../../Const/size.dart';
import 'addresslistingcontroller.dart';

class AddressListingScreen extends StatefulWidget {
  const AddressListingScreen({super.key});

  @override
  State<AddressListingScreen> createState() => _AddressListingScreenState();
}

class _AddressListingScreenState extends State<AddressListingScreen> {
  late AddressListingController controller;

  int _selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AddressListingController());
    controller.getAddress();
    // print(".................");
    // print(controller.addressList.value?.first.name);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressListingController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const Text("Delivery to"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            // height: height(context),
            child: addressListView(),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
            isLoading: false,
            onTap: () {
              Get.toNamed(Routes.addNewAddressScreen);
            },
            title: "Add New Address",
          ),
        ),
      );
    });
  }

  addressListView() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: controller.addressList.value?.length,
        itemBuilder: (context, index) {
          String? address =
              " ${controller.addressList.value?[index].addressLine1}, "
              " ${controller.addressList.value?[index].addressLine2}, "
              " ${controller.addressList.value?[index].addressLine3}, "
              " ${controller.addressList.value?[index].floorNo}, "
              "${controller.addressList.value?[index].unitNo}";

          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.addLocation,
                        scale: 3,
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: width(context) / 1.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Home",
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              address,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: MyFont.myFont,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Radio<int>(
                          value: index,
                          groupValue: _selectedIndex,
                          onChanged: (value) {
                            setState(() {
                              if (_selectedIndex == value) {
                                _selectedIndex =
                                    -1; // Deselect if already selected
                              } else {
                                _selectedIndex = value!; // Select the new one
                              }
                              // Update the selection state for each item
                              for (int i = 0;
                                  i < controller.addressList.value!.length;
                                  i++) {
                                controller.addressList.value![i].isSelected =
                                    (i == _selectedIndex);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  // Image.asset(
                  //   Assets.location,
                  //   scale: 3,
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
