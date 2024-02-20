import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widget/submitbutton.dart';
import '../../Widget/textformfield.dart';
import '../EditProfile/editprofilecontroller.dart';
import 'changepasswordcontroller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late ChangePasswordController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ChangePasswordController());
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
        title: const Text("Change Password"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.currentPassword,
              inputFormatters: [],
              hintText: "password",
            ),
            const SizedBox(height: 20),
            const Text(
              "New Password",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.newPassword,
              inputFormatters: [],
              hintText: "New Password",
            ),
            const SizedBox(height: 20),
            const Text(
              "Confirm Password",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 15),
            CustomTextFormField(
              controller: controller.confirmPassword,
              inputFormatters: [],
              hintText: "Confirm Password",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
            isLoading: false, onTap: () {}, title: "Update Password"),
      ),
    );
  }
}
