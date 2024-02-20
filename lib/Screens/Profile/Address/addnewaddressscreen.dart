import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Const/approute.dart';
import '../../Widget/submitbutton.dart';
import '../../Widget/textformfield.dart';
import 'addnewaddresscontroller.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late AddNewAddressController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(AddNewAddressController());
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
              hintText: "Name",
            ),
            const SizedBox(height: 20),
            const Text(
              "Email Address",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.emailController,
              inputFormatters: [],
              hintText: "Email",
            ),
            const SizedBox(height: 20),
            const Text(
              "Street address",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.streetAddController,
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
            const Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.phoneNumberController,
              inputFormatters: [],
              hintText: "Phone Number",
            ),
            const SizedBox(height: 20),
            const Text(
              "Location Type",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.locationTypeController,
              inputFormatters: [],
              hintText: "Location Type",
            ),
          ],
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
  }
}
