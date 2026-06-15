import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app/dashboard/data/product.dart';

// 👇 Change this to your actual PHP server URL
const String apiUrl = 'http://your-server.com/api/products.php';

final productProvider = FutureProvider<List<Product>>((ref) async {
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products (${response.statusCode})');
  }
});

//php code
// <?php
// header("Access-Control-Allow-Origin: *");
// header("Content-Type: application/json");

// $products = [
//     ["id" => 1, "name" => "Apple",  "price" => "50"],
//     ["id" => 2, "name" => "Banana", "price" => "20"],
//     ["id" => 3, "name" => "Mango",  "price" => "80"],
// ];

// echo json_encode($products);
