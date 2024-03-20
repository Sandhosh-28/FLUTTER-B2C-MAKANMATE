import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Const/size.dart';
import 'package:makkanmate/Screens/Category/ProductListing/productlistingcontroller.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/productmodel.dart';
import '../ProductDetail/productedtailcontroller.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  late ProductListingController controller;
  late ProductDetailController productDetailController;

  // late CategoryModel? categoryModel = CategoryModel();

  String? categoryCode;
  bool? checking;
  String? subcategoryCode;
  List<String> savedProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProductListingController());
    productDetailController = Get.put(ProductDetailController());
    final dynamic arguments = Get.arguments;
    checking = arguments["isMate"] as bool;
    categoryCode = arguments['categoryCode'] as String;
    controller.getAllSubCategoryList(categoryCode);
    if (checking == true) {
      productDetailController.cartService.cartChangeStream.listen((_) {
        setState(() {});
      });
    }
   if (checking == false) {
     productDetailController.cartService.mateChangeStream.listen((_) {
       setState(() {});
     });
   }
    initData();
  }

  late final List<ProductModel> localData;

  Future<void> initData() async {
    scrollController.addListener(_scrollListener);
    if (checking == true){
      localData = await PreferenceHelper.getCartData();
      if (localData != null) {
        for (int i = 0; i < localData.length; i++) {
          savedProduct.add(localData[i].productCode!);
        }
        productDetailController.cartAddedProduct.clear();
        productDetailController.cartAddedProduct.addAll(localData);
      }
    }

    if (checking == false) {
      localData = await PreferenceHelper.getmateData();
      if (localData != null) {
        for (int i = 0; i < localData.length; i++) {
          savedProduct.add(localData[i].productCode!);
        }
        productDetailController.mateAddedProduct.clear();
        productDetailController.mateAddedProduct.addAll(localData);
      }
    }
  }

  final ScrollController scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  Future<void> _scrollListener() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (controller.currentPage <= controller.totalPages &&
          !controller.status.isLoadingMore) {
        await controller.getProductByCategoryId(
            categoryId: categoryCode ?? '',
            subCategoryId: subcategoryCode ?? '',
            isPagination: true,
            subCategoryL2Name: "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListingController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return (controller.productList.isNotEmpty)
          ? Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.mainTheme,
          leading: IconButton(
              onPressed: () {
                Get.offAllNamed(Routes.userBottomNavBar);
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,color: MyColors.whiteTextFormField,)),
          title: const Text("Category",style: TextStyle(color: MyColors.whiteTextFormField),),

            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.search,
            //       color: MyColors.whiteTextFormField,
            //     )),
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.notifications_none,
            //       color: MyColors.whiteTextFormField,
            //     )),
            actions: [
              buildAppBarCartButton()
          ],
        ),
              body: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(18.0),
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "BENTO SET",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return (controller.subCategoryList.value != null)
                          ? SizedBox(
                              height: 50,
                              child: subCategoryList(),
                            )
                          : const SizedBox();
                    }),
                    (controller.subCategoryList.value != null)
                        ? const SizedBox(height: 20)
                        : const SizedBox(),
                    Obx(() {
                      return categoryProductGridView();
                    }),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: Center(
                child: Image.asset(Assets.noImage),
              ),
            );
    });
  }

  ///PRODUCT LISTING LISTVIEW & GRIDVIEW BUILDER

  int selectedListIndex = 0;

  subCategoryList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.subCategoryList.value?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                selectedListIndex = index;
                subcategoryCode = controller.subCategoryList.value?[index].code;
              });
              await controller.getProductByCategoryId(
                  categoryId: categoryCode ?? '',
                  subCategoryId:
                      controller.subCategoryList.value?[index].code ?? '',
                  isPagination: false,
                  subCategoryL2Name: '');

            },
            child: Card(
              color: selectedListIndex == index
                  ? MyColors.primaryCustom
                  : MyColors.whiteTextFormField,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  // searchLists[index].text.toUpperCase(),
                  controller.subCategoryList.value?[index].name ?? " ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: selectedListIndex == index
                        ? MyColors.whiteTextFormField
                        : MyColors.grey,
                  ),
                ),
              ),
            ),
          );
        });
  }

  categoryProductGridView() {
    // if (controller.productList.isNotEmpty) {
    //   return GridView.builder(
    //       shrinkWrap: true,
    //       itemCount: controller.productList.length,
    //       physics: const NeverScrollableScrollPhysics(),
    //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2,
    //         mainAxisExtent: 300,
    //         mainAxisSpacing: 10.0,
    //         crossAxisSpacing: 10.0,
    //       ),
    //       itemBuilder: (context, index) {
    //         return GestureDetector(
    //           onTap: () {
    //             Get.toNamed(Routes.productDetailScreen,
    //                 arguments: controller.productList[index].productCode);
    //           },
    //           child: Stack(
    //             alignment: Alignment.bottomCenter,
    //             children: [
    //               SizedBox(
    //                 height: 300,
    //                 width: 300,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(20.0),
    //                   child:
    //                   // controller.productList[index].productImagePath !=
    //                   //         null
    //                   //     ? Image.network(
    //                   //         controller.productList[index].productImagePath ??
    //                   //             "https://images.pexels.com/photos/327158/pexels-photo-327158.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    //                   //         fit: BoxFit.fill,
    //                   //       )
    //                   //     : Image.asset(
    //                   //         Assets.food1,
    //                   //         fit: BoxFit.fill,
    //                   //       ),
    //
    //                   (controller.productList[index]
    //                       .productImagePath !=
    //                       null)
    //                       ? ("${controller.productList[index].productImagePath}"
    //                       .isNotEmpty)
    //                       ? Image.network(
    //                     '${controller.productList[index].productImagePath}',
    //                     height: height(context) / 9,
    //                     width: width(context) / 5,
    //                     errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
    //                       return Image.asset(
    //                         Assets.noImage,
    //                         height: height(context) / 9,
    //                         width: width(context) / 5,
    //                       ); // Display error message
    //                     },
    //                   )
    //                       : Image.asset(
    //                     Assets.noImage,
    //                     height: height(context) / 9,
    //                     width: width(context) / 5,
    //                   )
    //                       : const Icon(Icons.error),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Image.asset(
    //                               Assets.mins,
    //                               scale: 2,
    //                               color: MyColors.mainTheme,
    //                             ),
    //                             const SizedBox(width: 5),
    //                             const Text(
    //                               "25 Mins",
    //                               overflow: TextOverflow.ellipsis,
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 color: MyColors.mainTheme,
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         Row(
    //                           children: [
    //                             Image.asset(
    //                               Assets.doller,
    //                               scale: 3,
    //                               color: MyColors.mainTheme,
    //                             ),
    //                             const SizedBox(width: 5),
    //                             const Text(
    //                               "2590",
    //                               overflow: TextOverflow.ellipsis,
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.bold,
    //                                 color: MyColors.mainTheme,
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     const Card(
    //                       color: MyColors.primaryCustom,
    //                       child: Padding(
    //                         padding: EdgeInsets.symmetric(
    //                             horizontal: 5, vertical: 5),
    //                         child: Text(
    //                           "49.5",
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             color: MyColors.whiteTextFormField,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           ),
    //         );
    //       });
    // }

    if ((controller.productList.value.isNotEmpty)) {
      return Column(
        children: [
          GridView.builder(
                shrinkWrap: true,
                itemCount: controller.productList.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.productDetailScreen, arguments: controller.productList[index].productCode);
                      Get.toNamed(Routes.productDetailScreen, arguments: {"isMate" : checking, "productCode" : controller.productList[index].productCode ?? ""} );

                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child:
                            // controller.productList[index].productImagePath !=
                            //         null
                            //     ? Image.network(
                            //         controller.productList[index].productImagePath ??
                            //             "https://images.pexels.com/photos/327158/pexels-photo-327158.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                            //         fit: BoxFit.fill,
                            //       )
                            //     : Image.asset(
                            //         Assets.food1,
                            //         fit: BoxFit.fill,
                            //       ),

                            (controller.productList[index]
                                .productImagePath !=
                                null)
                                ? ("${controller.productList[index].productImagePath}"
                                .isNotEmpty)
                                ? Image.network(
                              '${controller.productList[index].productImagePath}',
                              height: height(context) / 9,
                              width: width(context) / 5,
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return Image.asset(
                                  Assets.noproductImage,
                                  height: height(context) / 9,
                                  width: width(context) / 5,
                                ); // Display error message
                              },
                            )
                                : Image.asset(
                              Assets.noproductImage,
                              height: height(context) / 9,
                              width: width(context) / 5,
                            )
                                : const Icon(Icons.error),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        Assets.mins,
                                        scale: 2,
                                        color: MyColors.mainTheme,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "25 Mins",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.mainTheme,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        Assets.doller,
                                        scale: 3,
                                        color: MyColors.mainTheme,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        "2590",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.mainTheme,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Card(
                                color: MyColors.primaryCustom,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(
                                    "49.5",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.whiteTextFormField,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          if (controller.status.isLoadingMore)
            const Center(
                child: CircularProgressIndicator(color: MyColors.mainTheme)
            ),
        ],
      );
    } else if (controller.status.isLoadingMore || controller.status.isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: MyColors.mainTheme)
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 150),
          child: Text("No product Found"),
        ),
      );
    }
  }

  buildAppBarCartButton() {
    return Obx(() {
      return GestureDetector(
        onTap: () async {
          if (checking == true) {
            if (productDetailController.cartAddedProduct.isNotEmpty) {
              Get.toNamed(Routes.placeOrderScreen,
                  arguments:{"isMate" : true, "Products" : productDetailController.cartAddedProduct})
              // arguments: productDetailController.cartAddedProduct)
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
            if (productDetailController.mateAddedProduct.isNotEmpty) {
              Get.toNamed(Routes.placeOrderScreen,
                  arguments:{"isMate" : false, "Products" : productDetailController.mateAddedProduct})
              // arguments: productDetailController.mateAddedProduct)
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
                  color: MyColors.whiteTextFormField,
                ),
              ),
              if (checking == true && productDetailController.cartAddedProduct.isNotEmpty)
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
                        productDetailController.cartAddedProduct.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.whiteTextFormField,
                        ),
                      ),
                    ),
                  ),
                ),
              if (checking == false && productDetailController.mateAddedProduct.isNotEmpty)
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
