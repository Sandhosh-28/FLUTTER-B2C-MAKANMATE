import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makkanmate/Screens/Widget/submitbutton.dart';

import '../../Const/approute.dart';
import '../../Const/assets.dart';
import '../../Const/colors.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SubTotal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "\$ 80.90",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: MyColors.textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "\$ 00.00",
                  style: TextStyle(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "\$ 80.90",
                  style: TextStyle(
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
            onTap: () {
              showPopup(context);
            },
            title: "Place Order"),
      ),
    );
  }

  orderList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 3,
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
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cookie Sandwich",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Shortbread, chocolate turtle cookies, and red velvet",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                color: MyColors.textGrey,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "\$ 88.00",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Text(
                          "45",
                          style: TextStyle(
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

  showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          iconPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text(
            "Your Order Placed \nSuccessfully",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.black,
            ),
          ),
          content: const Text(
            "You placed the order successfully. You will get your food within 25 minutes. Thanks for using our services. Enjoy your food :)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: MyColors.textGrey,
            ),
          ),
          actions: [
            ButtonBar(alignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {},
                child: const Text("Keep Browsing"),
              ),
            ]),
          ],
          icon: SizedBox(
            height: 150.0,
            child: Image.asset(
              Assets.successfully,
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.userBottomNavBar);
    });
  }
}
