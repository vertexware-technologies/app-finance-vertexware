import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';

  /// Obtem o token do usuário armazenado no SharedPreferences.
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Método genérico para obter dados numéricos de endpoints.
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

  /// Método genérico para obter listas de dados de endpoints.
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
      // Decodifica a resposta JSON e acessa a propriedade 'data'
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> accounttypes = data['data'];
      // Converte os itens da lista para Map<String, dynamic>
      return accounttypes.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao buscar tipos de conta: ${response.statusCode}');
    }
  }

  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.post(
      Uri.parse('$baseUrl/transactions/new'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(transaction),
    );

    if (response.statusCode == 201) {
      // Transação criada com sucesso
    } else {
      throw Exception('Erro ao adicionar transação: ${response.statusCode}');
    }
  }

  /// Obtem o saldo total do usuário.
  Future<double> fetchTotalBalance() async {
    return fetchData('transactions/total-balance');
  }

  /// Obtem o total de investimentos do usuário.
  Future<double> fetchTotalInvestments() async {
    return fetchData('transactions/total-investments');
  }

  /// Obtem o total de despesas do usuário.
  Future<double> fetchTotalExpenses() async {
    return fetchData('transactions/total-expenses');
  }

  /// Obtem o total de rendimentos do usuário.
  Future<double> fetchTotalIncome() async {
    return fetchData('transactions/total-income');
  }
}
