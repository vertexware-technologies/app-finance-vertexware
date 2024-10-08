import 'dart:convert';
import 'package:finance_vertexware/Models/user.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl = 'http://finance-verteware.test/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result["data"];
    } else {
      throw Exception('Erro ao fazer login');
    }
  }

  Future<Map<String, dynamic>> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao fazer registro');
    }
  }
}
