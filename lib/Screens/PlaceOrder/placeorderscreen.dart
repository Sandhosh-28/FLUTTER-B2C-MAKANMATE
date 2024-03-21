import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Screens/PlaceOrder/placeordercontroller.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';
import '../../Const/fonts.dart';
import '../../Helper/api.dart';
import '../../Helper/preferenceHelper.dart';
import '../../ModelClass/SalesOrder.dart';
import '../Category/ProductDetail/productedtailcontroller.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  late PlaceOrderController controller = PlaceOrderController();

  double qtyTotal = 0;
  double price = 0;
  double shippingCharge = 0.00;
  double grandTotal = 0.00;
  double taxValue = 0;

  ///CURRENT DATE
  String currentDate = DateTime.now().toString();

  bool? checking;

  int selectedAddressIndex = -1;

  String? sendSalesAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    final dynamic arguments = Get.arguments;
    checking = arguments["isMate"] as bool;
    ProductDetailController _cartController =
        Get.put(ProductDetailController());
    if (checking == true) {
      controller.selectedItems = _cartController.cartAddedProduct.value;
      controller.cartService.cartChangeStream.listen((_) {});
    }

    if (checking == false) {
      controller.selectedItems = _cartController.mateAddedProduct.value;
      controller.cartService.mateChangeStream.listen((_) {});
    }
    controller.getAddress();
  }

  getUserData() async {
    await PreferenceHelper.getUserData().then((value) {
      customerId = value?.b2CCustomerId;
      b2CCustomerName = value?.b2CCustomerName;
      brachCode = value?.branchCode;
      emailId = value?.emailId;
      emailId = value?.mobileNo;
      postalCode = value?.postalCode;
      address = value?.addressLine1.toString();
      countryId = value?.countryId;
      orgId = value?.orgId.toString();
    });
  }

  ///GET CUSTOMER DATA
  String? customerId;
  String? orgId;
  String? countryId;
  String? address;
  String? postalCode;
  String? emailId;
  String? mobileNo;
  String? b2CCustomerName;
  String? brachCode;

  @override
  Widget build(BuildContext context) {
    double grandTotal = 0;
    double price = 0;

    ///PRICE
    for (var element in controller.selectedItems) {
      price += (element.qtyCount * element.sellingCost!);
      grandTotal = shippingCharge + price;

      ///SHIPPING CHARGERS
      if (price <= 49) {
        grandTotal = price + 5;
        shippingCharge = 5.00;
      } else if (price >= 50 && price <= 79) {
        grandTotal = price + 3;
        shippingCharge = 3.00;
      } else if (price >= 80) {
        grandTotal = price;
        shippingCharge = 0.00;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text("Your Orders"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            orderList(),
            const SizedBox(height: 20),
            Obx(() {
              return SizedBox(
                height: 200,
                child: Center(
                  child: getAddressListing(),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SubTotal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '\$ ${price.toStringAsFixed(2) ?? ""}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: MyColors.textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Shipping Charge",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '\$ ${shippingCharge.toStringAsFixed(2) ?? ""}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: MyColors.textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  '\$ ${grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: MyColors.textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            ListTile(
              onTap: () {},
              leading: const Text(
                "Add More Items",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.00,
                  color: MyColors.primaryCustom,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              leading: const Text(
                "Promo code",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16.00,
                  color: MyColors.primaryCustom,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: SubmitButton(
          isLoading: false,
          onTap: () async {
            if (controller.selectedAddress.isNotEmpty) {
              if (controller.selectedItems.first.qtyCount == 0) {
                controller.selectedItems.clear();
                controller.cartService.cartItems.clear();
                controller.updateProductCount();
                Get.offAllNamed(Routes.userBottomNavBar);
              } else {
                controller.salesOrder = SalesOrder(
                  orgId: HttpUrl.org,
                  brachCode: brachCode,
                  orderNo: "",
                  mobileNo: mobileNo,
                  emailId: emailId,
                  orderDate: currentDate,
                  customerId: customerId,
                  customerName: b2CCustomerName,
                  customerAddress: sendSalesAddress,
                  postalCode: postalCode,
                  taxCode: 0,
                  taxType: "E",
                  taxPerc: taxValue,
                  currencyCode: "",
                  currencyRate: 1,
                  total: price,
                  billDiscount: 0,
                  billDiscountPerc: 0,
                  subTotal: price,
                  tax: taxValue,
                  netTotal: grandTotal,
                  paymentType: "",
                  paidAmount: grandTotal,
                  remarks: "",
                  isActive: true,
                  createdBy: b2CCustomerName,
                  createdOn: currentDate,
                  changedBy: "admin",
                  changedOn: currentDate,
                  status: 0,
                  customerShipToId: 0,
                  customerShipToAddress: "",
                  latitude: 0,
                  longitude: 0,
                  signatureimage: "",
                  cameraimage: "",
                  orderDateString: currentDate,
                  createdFrom: "B2C",
                  customerEmail: emailId,
                  deliveryAmount: shippingCharge,
                  orderDetail: controller.selectedItems
                      .map((e) => OrderDetail(
                            orgId: HttpUrl.org,
                            orderNo: "",
                            slNo: 0,
                            productCode: e.productCode,
                            productName: e.productName,
                            qty: e.qtyCount.toInt(),
                            foc: 0,
                            price: e.sellingCost,
                            total: e.qtyCount.toInt() * e.sellingCost!,
                            itemDiscount: 0,
                            itemDiscountPerc: 0,
                            subTotal: e.qtyCount.toInt() * e.sellingCost!,
                            tax: taxValue,
                            netTotal: (e.qtyCount.toInt() * e.sellingCost!) +
                                (taxValue.toInt()),
                            taxCode: 0,
                            taxType: "E",
                            createdBy: "Admin",
                            taxPerc: 0,
                            createdOn: currentDate,
                            changedBy: "Admin",
                            changedOn: currentDate,
                            weight: 0,
                            remarks: "",
                          ))
                      .toList(),
                );
                controller.salesOrderApi();
              }
            }
          },
          title: "Place Order",
        ),
      ),
    );
  }

  orderList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.selectedItems.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Image.asset(Assets.food1),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.selectedItems[index].productName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Shortbread, chocolate turtle cookies, and red velvet",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: MyColors.textGrey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$ ${controller.selectedItems[index].sellingCost.toString()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: MyColors.primaryCustom,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            color: MyColors.grey,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          controller.selectedItems[index].qtyCount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: MyColors.primaryCustom,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 1),
              ],
            ),
          );
        });
  }

  getAddressListing() {
    return (controller.addressList.value != null &&
            controller.addressList.value!.isNotEmpty)
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: controller.addressList.value?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final isSelected = index == selectedAddressIndex;
              final address = controller.addressList.value?[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      // If the address is already selected, deselect it
                      selectedAddressIndex = -1;
                      controller.selectedAddress.clear();
                    } else {
                      // If a different address is selected, update the selection
                      selectedAddressIndex = index;
                      controller.selectedAddress.clear();
                      controller.selectedAddress.add(address!);
                    }
                  });
                  sendSalesAddress =
                      "${controller.selectedAddress.first.addressLine1},${controller.selectedAddress.first.floorNo},${controller.selectedAddress.first.unitNo},${controller.selectedAddress.first.addressLine2},${controller.selectedAddress.first.postalCode}";
                  print(sendSalesAddress);
                  print("cartController.selectedAddress.length");
                  print(controller.selectedAddress.length);
                  print(controller.selectedAddress.first.addressLine1);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: isSelected
                              ? MyColors.mainTheme
                              : Colors.transparent),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.addLocation,
                              scale: 3,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shipping address",
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: MyColors.primaryCustom,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${address?.unitNo}, ${address?.floorNo}, ${address?.addressLine1}, \n${address?.addressLine2}, ${address?.addressLine3}, \n${address?.postalCode}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Ph No •  ${controller.addressList.value?[index].phone}, \n",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: MyFont.myFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: MyColors.grey,
                                  ),
                                ),
                              ],
                            ),
                            // Theme(
                            //   data: ThemeData(
                            //     unselectedWidgetColor: MyColors
                            //         .white, // Change the color of unselected radio buttons
                            //   ),
                            //   child: Radio(
                            //     value: index,
                            //     groupValue: _selectedItemIndex,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         if (_selectedItemIndex == value) {
                            //           _selectedItemIndex = null;
                            //           controller.addressList.value?[index]
                            //               .isSelected = false;
                            //         } else {
                            //           _selectedItemIndex = value;
                            //           controller.addressList.value?.forEach(
                            //               (element) =>
                            //                   element.isSelected = false);
                            //           controller.addressList.value?[index]
                            //               .isSelected = true;
                            //         }
                            //       });
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
        : const Center(
            child: Text(
            "Add your Delivery Address",
          ));
  }
}
