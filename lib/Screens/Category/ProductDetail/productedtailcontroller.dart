import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController with StateMixin {
  String? topChoiceRadio;
  String? bottomChoiceRadio;

  RxBool isAddClick = true.obs;
}
