import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.5:3000/api";

  // Post method
  static Future<void> addProduct(
      Map<String, dynamic> customerProductDetails) async {
    var url = Uri.parse("$baseUrl/customer_product_details");

    try {
      log("Sending Data: $customerProductDetails");

      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(customerProductDetails),
      );

      log("Response Status: ${res.statusCode}");
      log("Response Body: ${res.body}");

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        log("Success: $data");
      } else {
        log("Failed to add product: ${res.body}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
