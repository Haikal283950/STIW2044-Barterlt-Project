import 'dart:convert';

import 'package:barterlt/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';

import '../myConfig.dart';

class Checkout extends StatefulWidget {
  final User user;
  const Checkout({super.key, required this.user, required int price});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(
                cardBgColor: Colors.black,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                isHolderNameVisible: true,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelText: "Card Number",
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 226, 240),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35))),
                  onChanged: (value) {
                    setState(() {
                      cardNumber = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      labelText: "Card Holder Name",
                      filled: true,
                      fillColor: Color.fromARGB(255, 214, 226, 240),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35))),
                  onChanged: (value) {
                    setState(() {
                      cardHolderName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            labelText: "Expiration Date",
                            filled: true,
                            fillColor: Color.fromARGB(255, 214, 226, 240),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35))),
                        onChanged: (value) {
                          setState(() {
                            expiryDate = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            labelText: "CVV",
                            filled: true,
                            fillColor: Color.fromARGB(255, 214, 226, 240),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35))),
                        onChanged: (value) {
                          setState(() {
                            cvvCode = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            isCvvFocused = true;
                          });
                        },
                        onFieldSubmitted: (_) {
                          setState(() {
                            isCvvFocused = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 150),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 14, 54, 141),
                    onPrimary: Color.fromARGB(255, 244, 54, 181),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                  ),
                  onPressed: () {
                    buyOrders();
                  },
                  child: Center(
                    child: Text(
                      "Pay now",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> buyOrders() async {
    http.post(Uri.parse(server + "/barterlt/php/update_cart.php"), body: {
      "user_id": widget.user.user_id,
      "product_id": widget.user.user_id,
    }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(response.body);
      if (jsondata['status'] == 'success') {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => main_screen(user: widget.user)));
      } else {
        print(response.body);
      }
    });
  }
}
