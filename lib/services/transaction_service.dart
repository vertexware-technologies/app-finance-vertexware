// lib/services/transaction_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      print("Token não encontrado.");
    } else {
      print("Token recuperado: $token");
    }
    return token;
  }

  Future<double> fetchTotalBalance() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/transactions/total-balance'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Dados de Saldo Total: $data");
      return data['total_balance']?.toDouble() ?? 0.0;
    } else {
      print('Erro ao obter saldo total: ${response.body}');
      throw Exception('Erro ao obter saldo total');
    }
  }

  Future<double> fetchTotalInvestments() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/transactions/total-investments'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['total_investments']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Failed to fetch investments');
    }
  }

  Future<double> fetchTotalExpenses() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/transactions/total-expenses'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['total_expenses']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Failed to fetch expenses');
    }
  }

  Future<double> fetchTotalIncome() async {
    String? token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/transactions/total-income'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['total_income']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Failed to fetch income');
    }
  }
}
