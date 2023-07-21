import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../model/product.dart';
import '../model/user.dart';
import '../myConfig.dart';
import 'login_screen.dart';

class itemDetails extends StatefulWidget {
  final User user;
  final Product product;
  const itemDetails({super.key, required this.product, required this.user});

  @override
  State<itemDetails> createState() => _itemDetailsState();
}

class _itemDetailsState extends State<itemDetails> {
  Future<User>? seller;
  String? productText;
  void initState() {
    super.initState();
    seller = sendRequest(widget.product.productId.toString());
    if (int.parse(widget.product.productQuantity) < 10) {
      productText =
          "Only " + widget.product.productQuantity.toString() + " left!";
    } else if (int.parse(widget.product.productQuantity) < 5) {
      productText =
          "Only " + widget.product.productQuantity.toString() + " left!";
    } else if (int.parse(widget.product.productQuantity) < 1) {
      productText = "Out of stock";
    } else {
      productText = "In stock";
    }
  }

  @override
  Widget build(BuildContext context) {
    List imageLists = [
      widget.product.image1,
      widget.product.image2,
      widget.product.image3,
      if (widget.product.image4 != '') widget.product.image4,
      if (widget.product.image5 != '') widget.product.image5,
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                child: CarouselSlider(
                  options: CarouselOptions(height: 500.0, autoPlay: true),
                  items: imageLists.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.network(
                          (server + "/barterlt/" + i),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          //Just a make a placeholder UI
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.productName,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        Text("RM" + widget.product.productPrice,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.product.productCity +
                                    ", " +
                                    widget.product.productRegion,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text(widget.product.productCountry,
                                style:
                                    Theme.of(context).textTheme.displayMedium)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Description",
                        style: Theme.of(context).textTheme.bodySmall),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(widget.product.productDescription,
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: Text("Owner of this item",
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                    FutureBuilder(
                        builder: ((context, snapshot) {
                          return Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Icon(Icons.person),
                                      ),
                                      Text((snapshot.hasData
                                          ? snapshot.data?.username ?? 'Loading'
                                          : 'Loading')),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0),
                                    child: Text(
                                        (snapshot.hasData
                                                ? snapshot.data?.first_name ??
                                                    'Loading'
                                                : 'Loading') +
                                            " " +
                                            (snapshot.hasData
                                                ? snapshot.data?.last_name ??
                                                    'Loading'
                                                : 'Loading'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        future:
                            sendRequest(widget.product.productId.toString())),
                    ElevatedButton(
                        onPressed: () {
                          widget.user.user_id == ""
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login_screen()))
                              : addToCart(
                                  widget.product.productId.toString(),
                                  widget.user.user_id.toString(),
                                  widget.product.seller_id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            Text("Add to cart"),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 80, 13, 204),
                            foregroundColor: Colors.white)),
                    Center(
                      child: Column(
                        children: [
                          Text(productText ?? 'Loading...',
                              style: Theme.of(context).textTheme.displayMedium),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Future<User> sendRequest(String product_id) async {
    final response = await http.post(
      Uri.parse(server + '/barterlt/php/fetch_user.php'),
      body: {'product_id': product_id},
    );

    print(response.body);
    var jsonData = jsonDecode(response.body);
    var userJson = jsonData[0];
    return User.fromJson(userJson);
  }

  Future<void> addToCart(
      String product_id, String user_id, String seller_id) async {
    print(
        "Client side logs\n" + product_id + "\n" + user_id + "\n" + seller_id);
    final response = await http
        .post(Uri.parse(server + "/barterlt/php/add_to_cart.php"), body: {
      'product_id': product_id,
      'user_id': user_id,
      'seller_id': seller_id
    }).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          print("Item inserted!");
          _showRoundedSnackbar(context, "Item added to cart!");
        } else {
          print("Item failed to be inserted!");
          _showRoundedSnackbar(context, "Item failed to be added to cart!");
        }
      } else {}
      print(response.body);
    });
  }

  Future<void> _showRoundedSnackbar(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add to Cart"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }
}
