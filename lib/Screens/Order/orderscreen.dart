import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../Widget/constructor.dart';
import 'ordercontroller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late OrderController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(OrderController());
    controller.getOrderList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (logic) {
      if (logic.isLoading.value == true) {
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
          title: const Text("Your Order"),
        ),
        body: controller.ordersModelList.value != null
            ? SingleChildScrollView(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    orderList(),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.noImage),
                    const SizedBox(height: 10),
                    const Text(
                      "Your Order List is Empty",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  ///PRODUCT LISTING LISTVIEW & GRIDVIEW BUILDER

  orderList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.ordersModelList.value?.length,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
              controller.ordersModelList.value?[index].orderDate.toString() ??
                  "");
          String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Date : ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: MyColors.primaryCustom,
                                      ),
                                    ),
                                    Text(
                                      orderDate,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.orderDetailScreen,
                                          arguments: controller.ordersModelList
                                              .value?.first.orderNo);
                                      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                      print(
                                          "${controller.ordersModelList.value?.first.orderNo}");
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Order Id : ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: MyColors.primaryCustom,
                                  ),
                                ),
                                Text(
                                  controller.ordersModelList.value?[index]
                                          .orderNo ??
                                      "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text(
                                    "Total Amount",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: MyColors.primaryCustom,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 50),
                                Flexible(
                                  child: Text(
                                    "\$  ${controller.ordersModelList.value?[index].netTotal.toString()}" ??
                                        "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  // orderList() {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: controller.ordersModelList.value?.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (context, index) {
  //         DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
  //             controller.ordersModelList.value?[index].orderDate.toString() ??
  //                 "");
  //         String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);
  //         return Padding(
  //           padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
  //           child: Column(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: BorderRadius.circular(10.0),
  //                     child: SizedBox(
  //                       height: 150,
  //                       child: Image.asset(
  //                         Assets.food1,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   const Flexible(
  //                     child: Padding(
  //                       padding: EdgeInsets.only(top: 10, bottom: 10),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             "Cookie Sandwich",
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 16.0,
  //                             ),
  //                           ),
  //                           SizedBox(height: 10),
  //                           Text(
  //                             "Shortbread, chocolate turtle cookies, and red velvet",
  //                             maxLines: 3,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.normal,
  //                               fontSize: 16.0,
  //                               color: MyColors.textGrey,
  //                             ),
  //                           ),
  //                           SizedBox(height: 10),
  //                           Row(
  //                             children: [
  //                               Text(
  //                                 "4 Items | 2.5 km",
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   color: MyColors.textGrey,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(height: 10),
  //                           Text(
  //                             "\$ 88.00",
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 15.0,
  //                               color: MyColors.primaryCustom,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Card(
  //                     elevation: 0,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(5.0),
  //                         side: const BorderSide(
  //                           color: MyColors.grey,
  //                         )),
  //                     child: const Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 10,
  //                         vertical: 10,
  //                       ),
  //                       child: Text(
  //                         "45",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.normal,
  //                           color: MyColors.primaryCustom,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               const Divider(thickness: 1),
  //             ],
  //           ),
  //         );
  //       });
  // }

  // categoryProductGridView() {
  //   return GestureDetector(
  //     onTap: () {
  //       Get.toNamed(Routes.productDetailScreen);
  //     },
  //     child: GridView.builder(
  //         shrinkWrap: true,
  //         itemCount: searchLists[selectedListIndex].productGrid.image.length,
  //         physics: const NeverScrollableScrollPhysics(),
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           mainAxisExtent: 300,
  //           mainAxisSpacing: 10.0,
  //           crossAxisSpacing: 10.0,
  //         ),
  //         itemBuilder: (context, index) {
  //           return Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               ClipRRect(
  //                 borderRadius: BorderRadius.circular(20.0),
  //                 child: Image.asset(
  //                   searchLists[selectedListIndex].productGrid.image[index],
  //                   fit: BoxFit.fill,
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
  //                             ),
  //                             const SizedBox(width: 5),
  //                             const Text(
  //                               "25 Mins",
  //                               overflow: TextOverflow.ellipsis,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: MyColors.whiteTextFormField,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             Image.asset(
  //                               Assets.doller,
  //                               scale: 3,
  //                             ),
  //                             const SizedBox(width: 5),
  //                             const Text(
  //                               "2590",
  //                               overflow: TextOverflow.ellipsis,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: MyColors.whiteTextFormField,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     const Card(
  //                       color: MyColors.primaryCustom,
  //                       child: Padding(
  //                         padding:
  //                             EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
  //           );
  //         }),
  //   );
  // }
}
