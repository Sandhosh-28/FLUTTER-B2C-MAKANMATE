import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Screens/Register/registrationcontroller.dart';
import 'package:pinput/pinput.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../Widget/submitbutton.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late RegistrationController controller;

  String? otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.find<RegistrationController>();
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              // Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text("OTP Verification"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A combination of digits has been sent to your chosen OTP.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: MyFont.myFont,
                    fontWeight: FontWeight.normal,
                    color: MyColors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Enter the OTP",
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.normal,
                        color: MyColors.black,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 5)),
                    TextSpan(
                      text: "*",
                      style: TextStyle(
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.normal,
                        color: MyColors.red,
                      ),
                    )
                  ])),
                ),
                const SizedBox(height: 20),
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
                    onCompleted: (pin) {
                      otp = pin;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: MyColors.mainTheme,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    ///CircularProgressIndicator need a condition to fix
                    // const SizedBox(
                    //   height: 20,
                    //   width: 20,
                    //   child: CircularProgressIndicator(),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
          isLoading: false,
          onTap: () {
            FocusScope.of(context).unfocus();
            controller.verifyOtp(otp);
          },
          title: 'Verify',
        ),
      ),
    );
  }
}
