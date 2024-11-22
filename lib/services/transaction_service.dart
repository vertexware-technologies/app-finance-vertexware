import 'dart:convert';
import 'package:finance_vertexware/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';

  // Função para obter o token armazenado
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Método genérico para obter dados numéricos de endpoints
  Future<double> fetchData(String endpoint) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final value = data.values.first;

      if (value is String) {
        return double.tryParse(value) ?? 0.0;
      } else if (value is num) {
        return value.toDouble();
      } else {
        throw Exception('Formato de dado inesperado no endpoint $endpoint');
      }
    } else {
      throw Exception(
          'Erro ao acessar $endpoint: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDataList(String endpoint) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao acessar $endpoint');
    }
  }

  Future<Map<String, dynamic>> addTransaction(Transaction transaction) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final requestBody = jsonEncode(transaction.toJson());

    final response = await http.post(
      Uri.parse('$baseUrl/transactions/new'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    // Tratar códigos de sucesso (200 e 201)
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['data'];
    } else {
      throw Exception(
          'Erro ao adicionar transação: ${response.statusCode} - ${response.body}');
    }
  }

  // Métodos para buscar dados específicos
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> accounttype = data['data'];
      return accounttype.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao buscar categorias: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAccountTypes() async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/account-types'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> accounttypes = data['data'];
      return accounttypes.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao buscar tipos de conta: ${response.statusCode}');
    }
  }

  // Métodos para buscar valores totais
  Future<double> fetchTotalBalance() async {
    return fetchData('transactions/total-balance');
  }

  Future<double> fetchTotalInvestments() async {
    return fetchData('transactions/total-investments');
  }

  Future<double> fetchTotalExpenses() async {
    return fetchData('transactions/total-expenses');
  }

  Future<double> fetchTotalIncome() async {
    return fetchData('transactions/total-income');
  }
}
