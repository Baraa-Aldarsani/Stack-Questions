import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;

  HttpClient({required this.baseUrl});

  Future<Map<String, dynamic>> get(String path) async {
    print("$baseUrl$path");
    final url = Uri.parse('$baseUrl$path');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
