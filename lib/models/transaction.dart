// lib/models/transaction.dart

class Transaction {
  final String title;
  final double amount;
  final String category;

  Transaction({
    required this.title,
    required this.amount,
    required this.category,
  });
}
