import 'package:cart_app/helpers/dbhelper.dart';
import 'package:cart_app/models/product_db_model.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<ProductDbModel>>? cartProduct;

  @override
  void initState() {
    super.initState();
    cartProduct = DBHelper.dbHelper.fetchALlCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: cartProduct,
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
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(productList[index].name),
                    subtitle: Text(productList[index].id),
                    trailing:
                        Text("${(productList[index].price).toString()} dollar"),
                  );
                },
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
