import 'dart:convert';
import 'package:finance_vertexware/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<User?> register(User user, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('data') && responseData['data'] != null) {
        // Garantir que nenhum valor seja nulo antes de criar o objeto User
        final data = responseData['data'];
        return User(
          name: data['name'] ?? 'Nome não informado',
          email: data['email'] ?? 'Email não informado',
          password: '', // O password nunca é retornado pela API, usamos vazio
        );
      }
      return null;
    } else if (response.statusCode == 422) {
      final errors =
          jsonDecode(response.body)['errors'] as Map<String, dynamic>;
      final errorMessage = errors.values.first.join(', ');
      throw Exception('Erro de validação: $errorMessage');
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
          'Erro ao registrar: ${errorBody['message'] ?? 'Erro desconhecido'}');
    }
  }

  // Login do usuário e armazenamento do token
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final String token = data['data']['token'];

      // Armazenar token usando FlutterSecureStorage
      await _secureStorage.write(key: 'token', value: token);
      print('Login realizado e token armazenado: $token');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  // Logout do usuário e remoção do token
  Future<void> logout() async {
    final String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Remover token usando FlutterSecureStorage
      await _secureStorage.delete(key: 'token');
      print('Logout realizado com sucesso');
    } else {
      throw Exception('Erro ao fazer logout: ${response.body}');
    }
  }

  // Obter o token armazenado
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
}
