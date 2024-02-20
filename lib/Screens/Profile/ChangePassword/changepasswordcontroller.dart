import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController with StateMixin {
  RxBool isCurrentPassVis = false.obs;
  RxBool isNewPassVis = false.obs;
  RxBool isConPassVis = false.obs;

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
}
