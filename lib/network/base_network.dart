import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = 'http://localhost:3000/';

  static Future<dynamic> getData(String endpoint) async {
  final response = await http.get(Uri.parse(baseUrl + endpoint));

  if (response.statusCode == 200) {
    try {
      final data = jsonDecode(response.body);
      print("Response body: ${response.body}");
      print("Parsed data type: ${data.runtimeType}");
      return data; // Kembalikan data (bisa berupa List atau Map)
    } catch (e) {
      throw Exception('Failed to parse data: $e');
    }
  } else {
    throw Exception('Failed to load data! Status code: ${response.statusCode}');
  }
}
}