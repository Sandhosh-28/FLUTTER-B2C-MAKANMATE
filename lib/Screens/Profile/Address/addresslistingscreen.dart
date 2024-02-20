import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import 'addresslistingcontroller.dart';

class AddressListingScreen extends StatefulWidget {
  const AddressListingScreen({super.key});

  @override
  State<AddressListingScreen> createState() => _AddressListingScreenState();
}

class _AddressListingScreenState extends State<AddressListingScreen> {
  late AddressListingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AddressListingController());
    controller.getAddress();
    print(".................");
    print(controller.addressList.value?.first.name);
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            addressListing(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubmitButton(
              isLoading: false,
              color: MyColors.lightGreen,
              textColor: MyColors.primaryCustom,
              onTap: () {
                // Get.toNamed(Routes.addNewAddressScreen);
              },
              title: "Select Address",
            ),
            const SizedBox(height: 10),
            SubmitButton(
              isLoading: false,
              onTap: () {
                Get.toNamed(Routes.addNewAddressScreen);
              },
              title: "Add New Address",
            ),
          ],
        ),
      ),
    );
  }

  addressListing() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.addressList.value?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  controller.isSelected.value = !controller.isSelected.value;
                });
              },
              child: Card(
                color: controller.isSelected.value ? MyColors.lightGreen : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.addLocation,
                        scale: 3,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                      .addressList.value?[index].addressLine1 ??
                                  "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller
                                      .addressList.value?[index].addressLine2 ??
                                  "",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: MyColors.primaryCustom,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
