import 'dart:convert';
import 'dart:developer';
import 'package:diploma_frontend/models/product.dart';
import 'package:diploma_frontend/models/user.dart';
import 'package:diploma_frontend/repositories/product_repository/base_product_repository.dart';
import 'package:diploma_frontend/services/database/database.dart';
import 'package:http/http.dart' as http;

class ProductRepository implements BaseProductRepository {
  final Database _database;
  ProductRepository(this._database);

  @override
  Future<List<Product>?> getProducts() async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Product/getProducts',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<Product>((e) {
          return Product.fromJson(e);
        }).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<List<String>?> getKinds({required int productId}) async {
    try {
      final User? user = await _database.getUser();
      final Uri url = Uri.parse(
        'https://restaurant-warehouse.azurewebsites.net/api/Product/getKinds?productId=$productId',
      );
      final Map<String, String> headers = {
        'accept': '*/*',
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${user!.token}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data.map<String>((e) {
          return e.toString();
        }).toList();
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
