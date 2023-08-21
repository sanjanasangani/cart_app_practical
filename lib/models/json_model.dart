import 'package:cart_app/models/product_model.dart';

class JsonModel {
  String jsonData;
  List<ProductModel> products;

  JsonModel({
    required this.jsonData,
    required this.products,
  });
}
