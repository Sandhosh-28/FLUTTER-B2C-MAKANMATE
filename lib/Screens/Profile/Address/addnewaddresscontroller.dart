import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewAddressController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetAddController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationTypeController = TextEditingController();
}
