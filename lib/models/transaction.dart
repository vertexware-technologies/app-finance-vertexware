import 'package:finance_vertexware/enum/payment_method.dart';

class Transaction {
  final int categoryId;
  final int accountTypeId;
  final String description;
  final double amount;
  final String date;
  final PaymentMethod paymentMethod;

  Transaction({
    required this.categoryId,
    required this.accountTypeId,
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'account_type_id': accountTypeId,
      'description': description,
      'amount': amount,
      'date': date,
      'payment_method': paymentMethod.value.toLowerCase(),
    };
  }
}
