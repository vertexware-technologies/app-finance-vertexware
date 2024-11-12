import 'package:finance_vertexware/enum/payment_method.dart';

class Transaction {
  final int userId;
  final int categoryId;
  final int accountTypeId;
  final String description;
  final double amount;
  final DateTime date;
  final PaymentMethod paymentMethod;

  Transaction({
    required this.userId,
    required this.categoryId,
    required this.accountTypeId,
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      userId: json['user_id'],
      categoryId: json['category_id'],
      accountTypeId: json['account_type_id'],
      description: json['description'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      paymentMethod: PaymentMethodExtension.fromString(json['payment_method']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'category_id': categoryId,
      'account_type_id': accountTypeId,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'payment_method': paymentMethod.value,
    };
  }
}
