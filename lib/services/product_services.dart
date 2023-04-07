import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hilman_mobile_apps/models/models.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  String baseUrl = 'https://apigenerator.dronahq.com/api/g7s7P925/TestAlan/';
  var secretToken =
      "\$2a\$16\$TlB6hYDRMSF5HBgxImeaU.itfBOu881/lI4mSPMR0jYRnMXklQKp6";

  Future<List<ProductModel>> getProducts() async {
    var headers = {'X-SECRET-TOKEN': secretToken};

    var response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      final List<ProductModel> products =
          data.map((item) => ProductModel.fromJson(item)).toList();

      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }

  Future<bool> addMenu({required ProductModel product}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    var body = jsonEncode(product.toJson());

    var response =
        await http.post(Uri.parse(baseUrl), headers: headers, body: body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
