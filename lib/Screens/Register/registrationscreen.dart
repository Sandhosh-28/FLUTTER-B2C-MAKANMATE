import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Helper/extension.dart';
import 'package:makkanmate/Screens/Register/registrationcontroller.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../../Const/size.dart';
import '../../Helper/api.dart';
import '../../ModelClass/customerregmodel.dart';
import '../Widget/submitbutton.dart';
import '../Widget/textformfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late RegistrationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(RegistrationController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registrationKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Enter your Name, Email and Password for sign up",
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.textGrey,
                  )),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.loginScreen);
                },
                child: const Text("Already have account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.primaryCustom,
                    )),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.nameController,
                inputFormatters: [],
                hintText: "Full Name",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Valid Name";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.emailController,
                inputFormatters: [EmailInputFormatter()],
                hintText: "Email Address",
                suffixIcon: const Icon(Icons.phone_android),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email id";
                  } else if (!validateEmail(value)) {
                    return "Invalid Email Id";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.passwordController,
                inputFormatters: [],
                hintText: "Password",
                obscureText: controller.isVis.value ? false : true,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      controller.isVis.value = !controller.isVis.value;
                    });
                  },
                  icon: controller.isVis.value
                      ? const Icon(Icons.visibility_outlined)
                      : const Icon(Icons.visibility_off_outlined),
                ),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Valid Password";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.unitNoController,
                inputFormatters: [],
                hintText: "Unit No",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Unit No";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.florNoController,
                inputFormatters: [],
                hintText: "Flor No",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Address Line 3";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine1Controller,
                inputFormatters: [],
                hintText: "Address Line 1",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Address Line 1";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine2Controller,
                inputFormatters: [],
                hintText: "Address Line 2",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Address Line 2";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.addressLine3Controller,
                inputFormatters: [],
                hintText: "Address Line 3",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Address Line 3";
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.postalCodeController,
                inputFormatters: [],
                hintText: "Postal Code",
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Enter Postal Code";
                  }
                },
              ),
              const SizedBox(height: 20),
              // const Center(
              //   child: Padding(
              //     padding: EdgeInsets.fromLTRB(18, 8, 18, 8),
              //     child: Text(
              //         "By Signing up you agree to our Terms Conditions & Privacy Policy.",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 16,
              //           color: MyColors.textGrey,
              //         )),
              //   ),
              // ),
              // const SizedBox(height: 20),
              // const Center(
              //   child: Text("Or",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontSize: 16,
              //         color: MyColors.textGrey,
              //       )),
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: MyColors.darkBlue,
              //       disabledBackgroundColor: Colors.transparent,
              //       minimumSize: Size(width(context), 50),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0), // <-- Radius
              //       ),
              //     ),
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           Assets.facebookLog,
              //           scale: 3.9,
              //         ),
              //         const SizedBox(width: 20),
              //         Text(
              //           "CONNECT WITH FACEBOOK",
              //           style: TextStyle(
              //               fontFamily: MyFont.myFont,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 12,
              //               color: Colors.white),
              //         ),
              //       ],
              //     )),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: MyColors.lightBlue,
              //       disabledBackgroundColor: Colors.transparent,
              //       minimumSize: Size(width(context), 50),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0), // <-- Radius
              //       ),
              //     ),
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           Assets.google,
              //           scale: 3.9,
              //         ),
              //         const SizedBox(width: 20),
              //         Text(
              //           "CONNECT WITH GOOGLE",
              //           style: TextStyle(
              //               fontFamily: MyFont.myFont,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 12,
              //               color: Colors.white),
              //         ),
              //       ],
              //     )),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: controller.isLoading.value == true
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              : SubmitButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (controller.registrationKey.currentState!.validate()) {
                      print("Working............");
                      controller.exitingEmailCheck();
                    }
                  },
                  title: 'Sign up',
                  isLoading: false,
                ),
        ),
      ),
    );
  }
}
