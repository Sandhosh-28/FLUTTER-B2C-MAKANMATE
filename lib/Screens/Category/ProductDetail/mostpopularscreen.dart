import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Screens/Category/ProductDetail/productedtailcontroller.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Const/colors.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/productmodel.dart';

class MostPopularItemList extends StatefulWidget {
  const MostPopularItemList({super.key});

  @override
  State<MostPopularItemList> createState() => _MostPopularItemListState();
}

class _MostPopularItemListState extends State<MostPopularItemList> {
  late ProductDetailController controller;

  bool? checking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProductDetailController());
    controller.mostPopularListView(true);
    // final dynamic arguments = Get.arguments;
    // checking = arguments["isMate"] as bool;
    // //
    // if (checking == true) {
    //   controller.cartService.cartChangeStream.listen((_) {
    //     setState(() {});
    //   });
    // }
    // if (checking == false) {
    //   controller.cartService.mateChangeStream.listen((_) {
    //     setState(() {});
    //   });
    // }
    // initData();
    // controller.updateProductCount();
  }

  late final List<ProductModel> localData;

  List<String> savedProduct = [];

  Future<void> initData() async {
    if (checking == true) {
      localData = await PreferenceHelper.getCartData();
      if (localData != null) {
        for (int i = 0; i < localData.length; i++) {
          savedProduct.add(localData[i].productCode!);
        }
        controller.cartAddedProduct.clear();
        controller.cartAddedProduct.addAll(localData);
      }
    }

    if (checking == false) {
      localData = await PreferenceHelper.getmateData();
      if (localData != null) {
        for (int i = 0; i < localData.length; i++) {
          savedProduct.add(localData[i].productCode!);
        }
        controller.mateAddedProduct.clear();
        controller.mateAddedProduct.addAll(localData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: const Text(
            "Most Popular Items",
          ),
          // actions: [buildAppBarCartButton()],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: mostPopularItemList(),
        ),
      );
    });
  }

  ///For You GridView Builder

  mostPopularItemList() {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 180,
        ),
        itemCount: controller.mostPopularBookList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(
                  "????????????${controller.mostPopularBookList.first.productCode}");
              Get.toNamed(Routes.productDetailScreen, arguments: {
                "isMate": true,
                "productCode":
                    controller.mostPopularBookList[index].productCode ?? ""
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: (controller.mostPopularBookList[index]
                                  .productImagePath !=
                              null)
                          ? (controller.mostPopularBookList[index]
                                  .productImagePath!.isNotEmpty)
                              ? Image.network(
                                  '${controller.mostPopularBookList[index].productImagePath}',
                                  fit: BoxFit.fill)
                              : Image.asset(Assets.noproductImage,
                                  fit: BoxFit.fill)
                          : Image.asset(Assets.noproductImage,
                              fit: BoxFit.fill)),
                ],
              ),
            ),
          );
        });
  }

  buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          if (checking == true) {
            if (controller.cartAddedProduct.isNotEmpty) {
              Get.toNamed(Routes.placeOrderScreen, arguments: {
                "isMate": true,
                "Products": controller.cartAddedProduct
              })
                  // arguments: controller.cartAddedProduct)
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
          }

          if (checking == false) {
            if (controller.mateAddedProduct.isNotEmpty) {
              Get.toNamed(Routes.placeOrderScreen, arguments: {
                "isMate": false,
                "Products": controller.mateAddedProduct
              })
                  // arguments: controller.mateAddedProduct)
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
                  color: MyColors.grey,
                ),
              ),
              if (checking == true && controller.cartAddedProduct.isNotEmpty)
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
                        controller.cartAddedProduct.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.whiteTextFormField,
                        ),
                      ),
                    ),
                  ),
                ),
              if (checking == false && controller.mateAddedProduct.isNotEmpty)
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
                        controller.mateAddedProduct.length.toString(),
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
