import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../Const/assets.dart';
import '../../../Const/fonts.dart';
import '../../Const/colors.dart';
import 'ordercontroller.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? orderNo;

  late OrderController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderNo = Get.arguments as String;
    controller = Get.put(OrderController());
    controller.getOrderDetails(orderNo);
    print(".......$orderNo");
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

      DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
          controller.ordersModelList.value?.first.orderDate.toString() ?? "");
      String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);

      var status = controller.ordersModelList.value?.first.status;

      String statusName = "";
      if (status == 0) {
        statusName = "open";
      } else if (status == 1) {
        statusName = "Delivered";
      } else if (status == 2) {
        statusName = "Return";
      } else {
        statusName = "Canceled";
      }

      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Order Details",
            style: TextStyle(
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Order Id : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: MyColors.primaryCustom,
                            )),
                        TextSpan(
                            text:
                                controller.ordersModelList.value?.first.orderNo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: MyColors.black,
                            )),
                      ])),
                  const SizedBox(width: 20),
                  Card(
                    color: MyColors.primaryCustom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Text(
                        statusName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.whiteTextFormField,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "Date : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: MyColors.primaryCustom,
                        )),
                    TextSpan(
                        text: orderDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: MyColors.black,
                        )),
                  ])),
              const SizedBox(height: 10),
              orderDetailListing(),
            ],
          ),
        ),
      );
    });
  }

  orderDetailListing() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.ordersDetailList.value?.first.orderDetail?.length,
        itemBuilder: (context, index) {
          return Card(
            // color: MyColors.yellow,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.ordersDetailList.value!.first.orderDetail?[index]
                            .productName ??
                        "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Qty",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primaryCustom,
                        ),
                      ),
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.primaryCustom,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${controller.ordersDetailList.value!.first.orderDetail![index].qty?.toStringAsFixed(2)} X ${controller.ordersDetailList.value!.first.orderDetail![index].price?.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.ordersDetailList.value!.first
                            .orderDetail![index].netTotal!
                            .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
