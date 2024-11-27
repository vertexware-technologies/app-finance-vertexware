import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:novo/controllers/auth_controller.dart';
import 'package:novo/models/transaction.dart';
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
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['data'];
      return items.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao acessar $endpoint');
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

  /// Método para buscar transações
  Future<List<Transaction>> fetchTransactions() async {
    try {
      final List<Map<String, dynamic>> transactionsData =
          await fetchDataList('transactions');
      return transactionsData
          .map((transactionData) => Transaction.fromJson(transactionData))
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar transações: $e');
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
      final List<dynamic> categories = data['data'];
      return categories.map((item) => item as Map<String, dynamic>).toList();
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

  Future<void> updateTransaction(Transaction transaction) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.put(
      Uri.parse('$baseUrl/transactions/update/${transaction.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Erro ao atualizar transação: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> editTransaction(Transaction transaction) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.put(
      Uri.parse('$baseUrl/transaction/update/${transaction.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(transaction.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar transação: ${response.body}');
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.delete(
      Uri.parse('$baseUrl/transaction/delete/$transactionId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
          'Erro ao excluir transação: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<Transaction>> fetchTransactionsByCategory(int categoryId) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/transactions/category/$categoryId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception(
          'Erro ao buscar transações por categoria: ${response.statusCode} - ${response.body}');
    }
  }

  Future<List<Transaction>> fetchTransactionsByAccountType(
      int accountTypeId) async {
    String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.get(
      Uri.parse('$baseUrl/transactions/account-type/$accountTypeId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception(
          'Erro ao buscar transações por tipo de conta: ${response.statusCode} - ${response.body}');
    }
  }
}
