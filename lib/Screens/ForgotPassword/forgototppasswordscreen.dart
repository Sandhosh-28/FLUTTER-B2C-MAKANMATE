import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../../Helper/preferencehelper.dart';
import '../Widget/submitbutton.dart';
import 'forgotpasswordcontroller.dart';

class ForgotPasswordOTPScreen extends StatefulWidget {
  const ForgotPasswordOTPScreen({super.key});

  @override
  State<ForgotPasswordOTPScreen> createState() =>
      _ForgotPasswordOTPScreenState();
}

class _ForgotPasswordOTPScreenState extends State<ForgotPasswordOTPScreen> {
  late ForgotPasswordController controller;

  String? otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ForgotPasswordController());
  }

  ///PinPutColorTheme
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontFamily: MyFont.myFont,
      fontSize: 22,
      color: MyColors.primaryCustom,
    ),
    decoration: BoxDecoration(
      color: MyColors.whiteTextFormField,
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: MyColors.grey),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                "Confirm Your Number",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Enter the 4 digit code sent to you at \n\n${controller.emailController.text}",
                style: TextStyle(
                  fontFamily: MyFont.myFont,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Pinput(
                  controller: controller.pinController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: MyColors.primaryCustom),
                    ),
                  ),
                  onChanged: (pin) {},
                  onCompleted: (pin) {
                    otp = pin;
                    controller.otp = otp;
                  },
                ),
              ),
              const SizedBox(height: 30),
              Center(
                  child: TextButton(
                      onPressed: () {
                        controller.sendOTP(true);
                      },
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.primaryCustom,
                        ),
                      )))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
            isLoading: false,
            onTap: () {
              if (otp?.length == 4 && otp != null && otp!.isNotEmpty) {
                controller.verifyOtp(context);
              } else {
                PreferenceHelper.getShowSnackBar(msg: "Please Enter the Otp");
              }
            },
            title: "Register"),
      ),
    );
  }

  showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            "Account Registered \nSuccessfully",
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
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
      Get.offAllNamed(Routes.loginScreen);
    });
  }
}
