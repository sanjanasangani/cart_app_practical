import 'package:cart_app/controllers/json_controller.dart';
import 'package:cart_app/models/product_db_model.dart';
import 'package:cart_app/models/product_model.dart';
import 'package:cart_app/utils/globals.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  static Database? db;

  Future initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "products.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS products(id TEXT PRIMARY KEY, name TEXT NOT NULL, price NUMERIC NOT NULL, quantity INTEGER NOT NULL);";

        String query1 =
            "CREATE TABLE IF NOT EXISTS cart(id TEXT, name TEXT NOT NULL, price NUMERIC NOT NULL, quantity INTEGER NOT NULL);";

        await db.execute(query);
        await db.execute(query1);
      },
    );
  }

  Future<void> insertProducts() async {
    await initDB();
    JsonController jsonController = JsonController();
    List<ProductModel> products = await jsonController.decodeJsonData();

    for (int i = 0; i < products.length; i++) {
      String query =
          "INSERT INTO products(id, name, price, quantity) VALUES(?, ?, ?, ?);";
      List args = [
        products[i].id,
        products[i].name,
        products[i].price,
        products[i].quantity,
      ];

      await db!.rawInsert(query, args);
    }

    getStorage.write("dataInserted", true);
  }

  Future<void> insertProductInCart({required ProductDbModel data}) async {
    await initDB();

    String query =
        "INSERT INTO cart(id, name, price, quantity) VALUES(?, ?, ?, ?);";
    List args = [
      data.id,
      data.name,
      data.price,
      data.quantity,
    ];

    await db!.rawInsert(query, args);
  }

  Future<List<ProductDbModel>> fetchALlProducts() async {
    await initDB();

    if (getStorage.read("dataInserted") != true) {
      await insertProducts();
    }

    String query = "SELECT * FROM products;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<ProductDbModel> allProducts =
        res.map((e) => ProductDbModel.fromMap(e)).toList();
    return allProducts;
  }

  Future<List<ProductDbModel>> fetchALlCartProducts() async {
    await initDB();

    String query = "SELECT * FROM cart;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<ProductDbModel> allProducts =
        res.map((e) => ProductDbModel.fromMap(e)).toList();
    return allProducts;
  }
}
