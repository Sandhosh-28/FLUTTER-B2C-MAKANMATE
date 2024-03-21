import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/colors.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/productmodel.dart';
import 'ProductDetail/productedtailcontroller.dart';
import 'categorycontroller.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryListController controller;
  late ProductDetailController productDetailController;
  List<String> savedProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(CategoryListController());
    productDetailController = Get.put(ProductDetailController());
    controller.getAllCategoryList();
    productDetailController.cartService.mateChangeStream.listen((_) {
      setState(() {});
    });
    initData();
  }

  late final List<ProductModel> localData;

  Future<void> initData() async {
    localData = await PreferenceHelper.getmateData();
    if (localData != null) {
      for (int i = 0; i < localData.length; i++) {
        savedProduct.add(localData[i].productCode!);
      }
      productDetailController.mateAddedProduct.clear();
      productDetailController.mateAddedProduct.addAll(localData);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryListController>(builder: (logic) {
      if (logic.isLoadings.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.userBottomNavBar);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          title: const Text("Category"),
          actions: [buildAppBarCartButton()],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Top Categories Menu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              categoryList(),
            ],
          ),
        ),
      );
    });
  }

  categoryList() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.martgoryList?.length,
        // controller.categoryList.value?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.productListingScreen, arguments: controller.categoryList.value?[index].code ?? "");
              Get.toNamed(Routes.productListingScreen, arguments: {"isMate" : false, "categoryCode" : controller.martgoryList?[index].code ?? ""} );
              print("<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>");
              print(controller.martgoryList?[index].code);
            },
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child:
                      // Image.asset(
                      //   Assets.food,
                      //   fit: BoxFit.fill,
                      // ),

                      ///Dynamic Changes
                      (controller.martgoryList?[index]
                                  .iconImageFilePath !=
                              null)
                          ? ("${controller.martgoryList?[index].iconImageFilePath}"
                                  .isNotEmpty)
                              ? Image.network(
                                  alignment: Alignment.center,
                                  controller.martgoryList?[index]
                                          .iconImageFilePath ??
                                      "",
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return Image.asset(
                                      Assets.food,
                                      fit: BoxFit.fill,
                                    ); //isplay error message
                                  },
                                )
                              : Image.asset(
                                  Assets.food,
                                  fit: BoxFit.fill,
                                )
                          : const Icon(Icons.error),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      controller.martgoryList?[index].name ?? "",
                      // "Korean",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: MyColors.whiteTextFormField,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }


  buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          if (productDetailController.mateAddedProduct.isNotEmpty) {
            Get.toNamed(Routes.placeOrderScreen,
                // arguments: productDetailController.mateAddedProduct)
                arguments:{"isMate" : false, "Products" : productDetailController.mateAddedProduct})
                ?.then((value) {
              if (value == true) {
                initData();
              }
            });
          } else {
            Get.showSnackbar(
              const GetSnackBar(
                margin: EdgeInsets.all(10),
                borderRadius: 10,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP,
                message: "Please select atleast one product",
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 11.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 11.0),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: MyColors.whiteTextFormField,
                ),
              ),
              if (productDetailController.mateAddedProduct.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 5,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffc32c37),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Center(
                      child: Text(
                        productDetailController.mateAddedProduct.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.whiteTextFormField,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
