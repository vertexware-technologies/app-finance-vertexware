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

  // Método de conversão para JSON
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

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      categoryId: json['category']['id'], // Extraindo categoria
      accountTypeId: json['account_type']['id'], // Extraindo tipo de conta
      description: json['description'],
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      date: json['date'],
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) =>
            e.toString().split('.').last.toLowerCase() ==
            json['payment_method'].toLowerCase(),
        orElse: () => PaymentMethod.PIX,
      ),
    );
  }
}
