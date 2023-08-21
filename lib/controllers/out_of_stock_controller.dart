import 'dart:async';

import 'package:cart_app/models/out_of_stock.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  Stock stock = Stock(isOutOfStock: false);

  outOfStock() {
    Timer(const Duration(seconds: 30), () {
      stock.isOutOfStock = true;
    });
    update();
  }
}
