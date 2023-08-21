import 'dart:async';
import 'dart:math';

import 'package:cart_app/controllers/out_of_stock_controller.dart';
import 'package:cart_app/helpers/dbhelper.dart';
import 'package:cart_app/models/product_db_model.dart';
import 'package:cart_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<ProductDbModel>>? products;
  StockController stockController = Get.put(StockController());

  @override
  void initState() {
    super.initState();
    products = DBHelper.dbHelper.fetchALlProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart App"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "cart_page");
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: FutureBuilder(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List<ProductDbModel>? productList = snapshot.data;

            if (productList!.isEmpty) {
              return const Center(
                child: Text("No data available"),
              );
            } else {
              Random r = Random();

              stockController.outOfStock();
              Timer(
                const Duration(seconds: 40),
                () {
                  setState(() {
                    selectIndex = r.nextInt(productList.length);
                  });
                },
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(productList[selectIndex].name),
                          subtitle: Text(productList[selectIndex].id),
                          trailing: Text(
                              "${(productList[selectIndex].price).toString()} dollar"),
                        );
                      },
                    ),
                  ),
                  GetBuilder<StockController>(builder: (context) {
                    return Text(
                      (stockController.stock.isOutOfStock)
                          ? "Out of Stock"
                          : "",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () {
                      DBHelper.dbHelper
                          .insertProductInCart(data: productList[selectIndex]);
                    },
                    child: const Text("Add to cart"),
                  ),
                ],
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
