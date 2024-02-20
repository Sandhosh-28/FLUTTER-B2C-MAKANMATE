import 'package:flutter/material.dart';

class CategoryList {
  final String text;
  final ProductGrid productGrid;

  CategoryList({required this.text, required this.productGrid});
}

class ProductGrid {
  final List<String> image;

  ProductGrid({required this.image});
}
