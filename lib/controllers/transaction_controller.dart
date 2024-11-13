import 'package:flutter/material.dart';
import '../services/transaction_service.dart';

class TransactionController extends ChangeNotifier {
  double _totalBalance = 0.0;
  double _totalInvestment = 0.0;
  bool _isLoading = false;

  double get totalBalance => _totalBalance;
  double get totalInvestment => _totalInvestment;
  bool get isLoading => _isLoading;

  final TransactionService _transactionService = TransactionService();

  // Função para buscar todos os dados de uma vez
  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fazendo as requisições simultaneamente
      var results = await Future.wait([
        _transactionService.fetchTotalBalance(),
        _transactionService.fetchTotalInvestments(),
      ]);

      // Atribuindo os resultados
      _totalBalance = results[0];
      _totalInvestment = results[1];
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
