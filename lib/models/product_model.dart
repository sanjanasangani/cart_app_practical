class ProductModel {
  String id;
  String name;
  double price;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'],
        name: data['name'],
        price: double.parse(data['price']),
        quantity: 0,
      );
}
