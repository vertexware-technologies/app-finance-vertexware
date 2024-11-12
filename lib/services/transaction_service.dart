import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
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
      return data['total_balance']?.toDouble() ?? 0.0;
    } else {
      throw Exception('Erro ao obter saldo total: ${response.body}');
    }
  }

  Future<double> fetchTotalInvestments() async {
    final response =
        await http.get(Uri.parse('$baseUrl/transactions/total-investments'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['total_investments'];
    } else {
      throw Exception('Failed to fetch investments');
    }
  }

  Future<double> fetchTotalExpenses() async {
    final response =
        await http.get(Uri.parse('$baseUrl/transactions/total-expenses'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['total_expenses'];
    } else {
      throw Exception('Failed to fetch expenses');
    }
  }

  Future<double> fetchTotalIncome() async {
    final response =
        await http.get(Uri.parse('$baseUrl/transactions/total-income'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['total_income'];
    } else {
      throw Exception('Failed to fetch income');
    }
  }
}
