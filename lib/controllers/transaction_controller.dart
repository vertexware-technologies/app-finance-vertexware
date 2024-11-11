// lib/controllers/transaction_controller.dart

import '../models/transaction.dart';

class TransactionController {
  // Mock data for demonstration
  final List<Transaction> transactions = [
    Transaction(title: 'Transação 1', amount: 100.0, category: 'general'),
    Transaction(title: 'Transação 2', amount: 500.0, category: 'investment'),
    Transaction(title: 'Despesa 1', amount: 50.0, category: 'expense'),
    Transaction(title: 'Investimento 1', amount: 150.0, category: 'investment'),
    Transaction(title: 'Despesa 2', amount: 30.0, category: 'expense'),
    Transaction(title: 'Transação 3', amount: 200.0, category: 'general'),
  ];

  List<Transaction> getLatestTransactions() {
    return transactions.take(3).toList();
  }

  List<Transaction> getLatestInvestments() {
    return transactions
        .where((tx) => tx.category == 'investment')
        .take(3)
        .toList();
  }

  List<Transaction> getLatestExpenses() {
    return transactions
        .where((tx) => tx.category == 'expense')
        .take(3)
        .toList();
  }
}
