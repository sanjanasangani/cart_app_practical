class ProductDbModel {
  String id;
  String name;
  double price;
  int quantity;

  ProductDbModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory ProductDbModel.fromMap(Map<String, dynamic> data) => ProductDbModel(
        id: data['id'],
        name: data['name'],
        price: data['price'],
        quantity: data['quantity'],
      );
}
