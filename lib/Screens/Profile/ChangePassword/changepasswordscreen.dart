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
    return Form(
      key: controller.changePassKey,
      child: Scaffold(
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
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Current Password";
                  } else {
                    return null;
                  }
                },
                obscureText: controller.isCurrentPassVis.value ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isCurrentPassVis.value =
                          !controller.isCurrentPassVis.value;
                    });
                  },
                  icon: Icon(controller.isCurrentPassVis.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
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
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter New Password";
                  } else if (controller.currentPassword.text ==
                      controller.newPassword.text) {
                    return "New Password & Current Password are same";
                  } else {
                    return null;
                  }
                },
                obscureText: controller.isNewPassVis.value ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isNewPassVis.value =
                          !controller.isNewPassVis.value;
                    });
                  },
                  icon: Icon(controller.isNewPassVis.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
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
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Confirm Password";
                  } else if (controller.newPassword.text !=
                      controller.confirmPassword.text) {
                    return "Confirm Password Doesn't Match";
                  } else {
                    return null;
                  }
                },
                obscureText: controller.isConPassVis.value ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isConPassVis.value =
                          !controller.isConPassVis.value;
                    });
                  },
                  icon: Icon(controller.isConPassVis.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SubmitButton(
              isLoading: false,
              onTap: () {
                if (controller.changePassKey.currentState!.validate()) {
                  controller.checkCurrentPassword();
                }
              },
              title: "Update Password"),
        ),
      ),
    );
  }
}
