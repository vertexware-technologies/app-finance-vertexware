import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/app_urls.dart';

class HttpService {
  final String baseUrl = AppUrls.base;

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      });

    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: defaultHeaders);
      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception('Erro ao realizar GET: $e');
    }
  }

  Future<http.Response> post(String endpoint,
      {Object? body, Map<String, String>? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      });

    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response =
          await http.post(url, headers: defaultHeaders, body: jsonEncode(body));
      _handleResponse(response);
      return response;
    } catch (e) {
      throw Exception('Erro ao realizar POST: $e');
    }
  }

  void _handleResponse(http.Response response) {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(response.statusCode);
    print(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
          'Erro na requisição: ${response.statusCode}, ${response.body}');
    }
  }
}
