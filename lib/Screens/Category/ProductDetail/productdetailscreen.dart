import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Const/colors.dart';
import 'package:makkanmate/Const/size.dart';
import 'package:makkanmate/Screens/Category/ProductDetail/productedtailcontroller.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../../Const/approute.dart';
import '../../../Const/assets.dart';
import '../../../Helper/preferenceHelper.dart';
import '../../../ModelClass/productmodel.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late ProductDetailController controller;
  bool? checking;

  String? productCode;

  List<String> savedProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ProductDetailController());
    final dynamic arguments = Get.arguments;
    checking = arguments["isMate"] as bool;
    productCode = arguments['productCode'] as String;
    print("<<<<<<<<$checking>>>>>>>$productCode");
    controller.productGetByCode(productCode,checking);
    if (checking == true) {
      controller.cartService.cartChangeStream.listen((_) {
        setState(() {});
      });
    }
    if (checking == false) {
      controller.cartService.mateChangeStream.listen((_) {
        setState(() {});
      });
    }
    initData();
    controller.updateProductCount();
  }

  late final List<ProductModel> localData;

  Future<void> initData() async {
    if (checking == true){
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: MyColors.mainTheme,
              expandedHeight: 280,
              pinned: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined,color: MyColors.whiteTextFormField,),
              ),
              title: const Text("Product Detail",style: TextStyle(color: MyColors.whiteTextFormField),),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  Assets.banner,
                  fit: BoxFit.fill,
                ),
              ),
              actions: [
                buildAppBarCartButton()
              ],
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 80,
                      child: productGalleryListView(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  controller.productList.first.productName ??
                                      "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Review"))
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened."
                            "Shortbread, chocolate turtle cookies, and red velvet. 8 ounces cream cheese, softened.",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              color: MyColors.textGrey,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Add's On",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Card(
                                elevation: 0,
                                color: MyColors.lightOrange,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Text(
                                    "Required".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Obx(() {
                            return choiceListView();
                          }),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Choice of Bottom Cookie",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Card(
                                elevation: 0,
                                color: MyColors.lightOrange,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Text(
                                    "Required".toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          bottomChoiceListView(),
                          const SizedBox(height: 10),
                          ListTile(
                            onTap: () {},
                            leading: const Text(
                              "Add Special Instructions",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                              ),
                            ),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_outlined),
                          ),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10),
                          //ADD Button
                          if (checking == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {

                                  ProductModel? selectedProduct =
                                      controller.productList.first;

                                  setState(() {
                                    controller.cartService.removeFromCart(
                                        product: selectedProduct);
                                    controller.updateProductCount();
                                  });

                                  if (selectedProduct.qtyCount == 0) {
                                    if (controller.cartAddedProduct.any(
                                        (element) =>
                                            element.productCode ==
                                            selectedProduct.productCode)) {
                                      var selectedIndex = controller
                                          .cartAddedProduct
                                          .indexWhere((element) =>
                                              element.productCode ==
                                              selectedProduct.productCode);

                                      controller.cartAddedProduct
                                          .removeAt(selectedIndex);
                                      if (controller
                                          .cartAddedProduct.isEmpty) {
                                        controller.cartAddedProduct.clear();
                                      }
                                    }
                                  }
                                  // bottomAppBar(index);
                                  // if (controller.productList[index].qtycount == 0) {
                                  //   controller.cartAddedProduct.length = 0;
                                  // }
                                  await PreferenceHelper.saveCartData(controller.cartAddedProduct);
                                },
                                icon: Image.asset(Assets.minusButton,
                                  scale: 4,
                                ),
                                // iconSize: 50,
                              ),
                              const SizedBox(width: 20),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return ScaleTransition(
                                      scale: animation, child: child);
                                },
                                child: SizedBox(
                                  width: 20,
                                  child: Text(
                                    '${controller.productList.first.qtyCount.toInt()}',
                                    key: ValueKey<int>(
                                      controller.productList.first.qtyCount
                                              .toInt() ??
                                          0,
                                    ),
                                    style: const TextStyle(
                                      color: MyColors.black,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () async {
                                  ProductModel? selectedProduct =
                                      controller.productList.value.first;
                                  if (savedProduct.contains(
                                      selectedProduct.productCode)) {
                                    var selectedIndex = controller
                                        .cartAddedProduct
                                        .indexWhere((element) =>
                                            element.productCode ==
                                            selectedProduct.productCode);

                                    controller.cartAddedProduct
                                        .removeAt(selectedIndex);
                                    savedProduct
                                        .remove(selectedProduct.productCode);
                                  }
                                  setState(() {
                                    controller.cartService
                                        .addToCart(product: selectedProduct);
                                    controller.updateProductCount();
                                  });

                                  if (selectedProduct.qtyCount != 0) {
                                    bool isAlreadyAdded = controller
                                        .cartAddedProduct
                                        .any((element) =>
                                            element.productCode ==
                                            selectedProduct.productCode);

                                    if (!isAlreadyAdded) {
                                      controller.cartAddedProduct
                                          .add(selectedProduct);
                                    }
                                  }
                                  await PreferenceHelper.saveCartData(
                                      controller.cartAddedProduct);
                                },
                                icon: Image.asset(Assets.plusButton,     scale: 4,
                                ),
                                // iconSize: 50,
                              ),
                            ],
                          ),
                          if (checking == false)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {

                                    ProductModel? selectedProduct =
                                        controller.productList.first;

                                    setState(() {
                                      controller.cartService.removeFromCart1(
                                          product: selectedProduct);
                                      controller.updateProductCount1();
                                    });

                                    if (selectedProduct.qtyCount == 0) {
                                      if (controller.mateAddedProduct.any(
                                              (element) =>
                                          element.productCode ==
                                              selectedProduct.productCode)) {
                                        var selectedIndex = controller
                                            .mateAddedProduct
                                            .indexWhere((element) =>
                                        element.productCode ==
                                            selectedProduct.productCode);

                                        controller.mateAddedProduct
                                            .removeAt(selectedIndex);
                                        if (controller.mateAddedProduct.isEmpty) {
                                          controller.mateAddedProduct.clear();

                                        }
                                      }
                                    }
                                    // bottomAppBar(index);
                                    // if (controller.productList[index].qtycount == 0) {
                                    //   controller.cartAddedProduct.length = 0;
                                    // }
                                    await PreferenceHelper.savemateData(controller.mateAddedProduct);
                                  },
                                  icon: Image.asset(Assets.minusButton,
                                    scale: 4,
                                  ),
                                  // iconSize: 50,
                                ),
                                const SizedBox(width: 20),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return ScaleTransition(
                                        scale: animation, child: child);
                                  },
                                  child: SizedBox(
                                    width: 20,
                                    child: Text(
                                      '${controller.productList.first.qtyCount.toInt()}',
                                      key: ValueKey<int>(
                                        controller.productList.first.qtyCount
                                            .toInt() ??
                                            0,
                                      ),
                                      style: const TextStyle(
                                        color: MyColors.black,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () async {
                                    ProductModel? selectedProduct =
                                        controller.productList.value.first;
                                    print("selectedProduct");
                                    print(selectedProduct);
                                    if (savedProduct.contains(
                                        selectedProduct.productCode)) {
                                      var selectedIndex = controller
                                          .mateAddedProduct
                                          .indexWhere((element) =>
                                      element.productCode ==
                                          selectedProduct.productCode);

                                      controller.mateAddedProduct
                                          .removeAt(selectedIndex);
                                      savedProduct
                                          .remove(selectedProduct.productCode);
                                    }
                                    setState(() {
                                      controller.cartService
                                          .addToCart1(product: selectedProduct);
                                      controller.updateProductCount1();
                                    });

                                    if (selectedProduct.qtyCount != 0) {
                                      bool isAlreadyAdded = controller
                                          .mateAddedProduct
                                          .any((element) =>
                                      element.productCode ==
                                          selectedProduct.productCode);

                                      if (!isAlreadyAdded) {
                                        controller.mateAddedProduct
                                            .add(selectedProduct);
                                      }
                                    }
                                    print("controller.mateAddedProduct.length");
                                    print(controller.mateAddedProduct.length);
                                    await PreferenceHelper.savemateData(
                                        controller.mateAddedProduct);
                                    var data = await PreferenceHelper.getmateData();
                                    print("data.length");
                                    print(data.length);
                                  },
                                  icon: Image.asset(Assets.plusButton,     scale: 4,
                                  ),
                                  // iconSize: 50,
                                ),
                              ],
                            ),
                          const SizedBox(height: 10),
                          SubmitButton(
                              isLoading: false,
                              onTap: () {
                                Get.toNamed(Routes.placeOrderScreen,
                                    arguments: controller.cartAddedProduct);
                              },
                              title: "ADD"),
                          const SizedBox(height: 20),
                          const Text(
                            "Featured Items",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 250,
                            child: featuredListView(),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Most Popular",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 250,
                            child: mostPopularListView(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  ///PRODUCT GALLERY IMAGES LISTVIEW
  productGalleryListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                  width: 80,
                  child: Image.asset(
                    Assets.food,
                    fit: BoxFit.fill,
                  )),
            ),
          );
        });
  }

  ///TOP CHOICES LISTVIEW

  List choiceName = [
    "Chocolate Chip",
    "Cookies and Cream",
    "Funfetti",
    "Peanut Butter",
  ];

  choiceListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.productList.first.masterCustomAddOn?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  // Radio<String>(
                  //   value: choiceName[index],
                  //   groupValue: controller.topChoiceRadio,
                  //   onChanged: (String? value) {
                  //     setState(() {
                  //       controller.topChoiceRadio = value;
                  //     });
                  //   },
                  // ),
                  Text(
                    controller.productList.first.masterCustomAddOn?[index]
                            .productId ??
                        "",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: MyColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1)
            ],
          );
        });
  }

  ///BOTTOM CHOICES LISTVIEW

  List bottomChoiceName = [
    "Chocolate Chip",
    "Cookies and Cream",
    "Funfetti",
    "Peanut Butter",
  ];

  bottomChoiceListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: choiceName.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: choiceName[index],
                    groupValue: controller.bottomChoiceRadio,
                    onChanged: (String? value) {
                      setState(() {
                        controller.bottomChoiceRadio = value;
                      });
                    },
                  ),
                  Text(
                    choiceName[index],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: MyColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1)
            ],
          );
        });
  }

  ///FEATURED ITEMS LISTVIEW

  featuredListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        Assets.food3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Chow Fun",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "\$ 8.00",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Chinese",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///MOST POPULAR
  mostPopularListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        Assets.item,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Cookie Sandwich",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "\$ 8.00",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Chinese",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 15, color: MyColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
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
              Get.toNamed(Routes.placeOrderScreen,
                  arguments:{"isMate" : true, "Products" : controller.cartAddedProduct})
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
              Get.toNamed(Routes.placeOrderScreen,
                  arguments:{"isMate" : false, "Products" : controller.mateAddedProduct})
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
                  color: MyColors.whiteTextFormField,
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
