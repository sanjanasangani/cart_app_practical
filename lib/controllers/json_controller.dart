import 'dart:convert';

import 'package:cart_app/models/json_model.dart';
import 'package:cart_app/models/product_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class JsonController extends GetxController {
  JsonModel jsonModel = JsonModel(jsonData: "", products: []);

  Future<List<ProductModel>> decodeJsonData() async {
    String path = "lib/resources/products.json";
    jsonModel.jsonData = await rootBundle.loadString(path);

    List decodedList = jsonDecode(jsonModel.jsonData);

    jsonModel.products =
        decodedList.map((e) => ProductModel.fromMap(e)).toList();

    return jsonModel.products;
  }
}
