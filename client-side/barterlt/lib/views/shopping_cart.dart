import 'dart:convert';

import 'package:barterlt/views/check_out.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../model/user.dart';
import '../myConfig.dart';

class ShoppingCart extends StatefulWidget {
  final User user;
  const ShoppingCart({super.key, required this.user});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  void initState() {
    super.initState();
    fetchCarts();
  }

  List<Product> productList = <Product>[];
  List<Product> sameSeller = <Product>[];
  int price = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
              flex: 87,
              child: productList.isEmpty
                  ? Center(child: Text("Your cart is empty!"))
                  : Center(
                      child: ListView.builder(
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return makeItemCard(
                                productList[index], size, context);
                          }),
                    )),
          Expanded(
            flex: 13,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                            "Total Price of all items = RM" + price.toString()),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 14, 54, 141),
                          onPrimary: Color.fromARGB(255, 244, 54, 181),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Checkout(
                                        user: widget.user,
                                        price: price,
                                      )));
                        },
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        )),
                  ],
                )),
          ),
        ],
      )),
    );
  }

  Container makeItemCard(Product product, Size size, BuildContext context) {
    String user = product.seller_id;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              child: Container(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.productName),
                          Text("Seller : ID" + user,
                              style: Theme.of(context).textTheme.displayMedium),
                          Text("RM" + product.productPrice,
                              style: Theme.of(context).textTheme.displayMedium),
                          Container(
                            width: 180,
                            child: Text(
                              product.productCity +
                                  ", " +
                                  product.productRegion,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                      ),
                      Container(
                        child: Image.network(
                            server + "/barterlt/" + product.image1),
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        removeItem(product);
                      },
                      child: Text("Remove Item"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 218, 16, 16)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255))))
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ))
        ],
      ),
    );
  }

  Future<void> removeItem(Product product) async {
    http.post(Uri.parse(server + "/barterlt/php/delete_from_cart.php"), body: {
      'user_id': widget.user.user_id,
      'product_id': product.productId.toString(),
    }).then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == "success") {
          setState(() {
            productList.removeWhere(
                (element) => element.productId == product.productId);
          });
        }
      }
    });
  }

  Future<void> fetchCarts() async {
    http.post(Uri.parse(server + "/barterlt/php/fetch_cart.php"), body: {
      'user_id': widget.user.user_id,
    }).then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        for (var item in jsonResponse['data']) {
          Product product = Product.fromJson(item);
          productList.add(product);
        }
        setState(() {
          for (var price in productList) {
            this.price += int.parse(price.productPrice);
          }
        });
      }
    });
  }
}
