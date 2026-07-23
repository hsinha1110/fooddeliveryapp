import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/bottom_nav.dart';
import 'package:fooddeliveryapp/model/food_list.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fooddeliveryapp/services/database.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final FoodList food;
  const Details({super.key, required this.food});

  @override
  State<Details> createState() => _DetailsState();
}

DatabaseMethods databaseMethods = DatabaseMethods();

Future<Map<String, dynamic>> createPaymentIntent(
  String amount,
  String currency,
) async {
  final response = await http.post(
    Uri.parse("http://localhost:3000/payment-sheet"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"amount": amount, "currency": currency}),
  );

  print("Status Code: ${response.statusCode}");
  print("Response: ${response.body}");

  if (response.statusCode != 200) {
    throw Exception("Server Error: ${response.body}");
  }

  return jsonDecode(response.body);
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  Map<String, dynamic>? paymentIntent;

  Future<void> showOrderSuccessDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 10),
              Text("Success"),
            ],
          ),
          content: const Text("🎉 Your order has been placed successfully."),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    Navigator.of(context).pop(); // Dialog close

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const BottomNav()),
      (route) => false,
    );
  }

  Future<void> makePayment(double totalPrice) async {
    try {
      paymentIntent = await createPaymentIntent(
        (totalPrice * 100).toInt().toString(),
        "inr",
      );

      print(paymentIntent);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: "Food Delivery",
          customerId: paymentIntent!["customer"],
          customerEphemeralKeySecret: paymentIntent!["ephemeralKey"],
          paymentIntentClientSecret: paymentIntent!["paymentIntent"],
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      await DatabaseMethods().addOrder(
        foodName: widget.food.Title,
        foodImage: widget.food.Image,
        quantity: quantity,
        total: totalPrice,
      );

      await showOrderSuccessDialog(context);
    } on StripeException catch (e) {
      print(e.error.localizedMessage);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double price = double.parse(widget.food.Price.replaceAll("\$", ""));
    double totalPrice = price * quantity;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 15),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffef2b39),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),

                Image.asset(
                  widget.food.Image,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.food.Title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    widget.food.Price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffef2b39),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.food.Description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffef2b39),
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            "$quantity",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 10),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              });
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffef2b39),
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 150.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffef2b39),
                              child: Container(
                                width: 100.0,
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  "\$${totalPrice.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await makePayment(totalPrice);
                            },
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                height: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  "Order Now".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
