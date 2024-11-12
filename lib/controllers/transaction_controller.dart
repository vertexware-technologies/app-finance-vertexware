// lib/controllers/transaction_controller.dart

import 'package:finance_vertexware/models/transaction.dart';

class TransactionController {
  // Lista de transações reais
  final List<Transaction> transactions;

  // Construtor para inicializar o controlador com uma lista de transações
  TransactionController({required this.transactions});

  // Método para obter as últimas transações
  List<Transaction> getLatestTransactions() {
    return transactions.take(3).toList();
  }

  // Método para obter os últimos investimentos
  List<Transaction> getLatestInvestments() {
    return transactions.where((tx) => tx.categoryId == 3).take(3).toList();
  }

  // Método para obter as últimas despesas
  List<Transaction> getLatestExpenses() {
    return transactions.where((tx) => tx.categoryId == 2).take(3).toList();
  }
}
