import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../../Helper/preferenceHelper.dart';
import '../../Widget/textformfield.dart';
import 'editprofilecontroller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileController controller;

  String? b2cCustomerId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    controller = Get.put(EditProfileController());
  }

  void getUserData() async {
    await PreferenceHelper.getUserData().then((value) => setState(() {
          b2cCustomerId = "${value?.b2CCustomerId}";
          controller.nameController.text = "${value?.b2CCustomerName}";
          controller.phoneController.text = "${value?.mobileNo}";
          controller.emailController.text = "${value?.emailId}";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.updateProfileKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.nameController,
                inputFormatters: [],
                hintText: "Full Name",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Name";
                  } else {
                    return null;
                  }
                },
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
                readOnly: true,
                hintText: "Email Address",
              ),
              const SizedBox(height: 20),
              const Text(
                "Mobile Number",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: controller.phoneController,
                inputFormatters: [],
                hintText: "Mobile Number",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Mobile Number";
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
              isLoading: false,
              onTap: () {
                if (controller.updateProfileKey.currentState!.validate()) {
                  print('....$b2cCustomerId........');
                  controller.updateProfile(b2cCustomerId);
                }
              },
              title: "Update Profile"),
        ),
      ),
    );
  }
}
