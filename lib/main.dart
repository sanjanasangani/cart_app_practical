import 'package:cart_app/views/screens/cart_page.dart';
import 'package:cart_app/views/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      routes: {
        "/": (context) => const HomePage(),
        "cart_page": (context) => const CartPage(),
      },
    ),
  );
}
