import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../Widget/textformfield.dart';
import 'editprofilecontroller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late EditProfileController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(EditProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
            isLoading: false, onTap: () {}, title: "Update Profile"),
      ),
    );
  }
}
