import 'package:finance_vertexware/enum/payment_method.dart';

class Transaction {
  final int categoryId;
  final int accountTypeId;
  final String accountTypeName; // Mudamos para String, pois agora é só exibição
  final String description;
  final double amount;
  final String date;
  final PaymentMethod paymentMethod;

  Transaction({
    required this.categoryId,
    required this.accountTypeId,
    required this.accountTypeName, // Passamos o nome aqui para exibição
    required this.description,
    required this.amount,
    required this.date,
    required this.paymentMethod,
  });

  // Método de conversão para JSON
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'account_type_id': accountTypeId, // Apenas o ID será salvo
      'description': description,
      'amount': amount,
      'date': date,
      'payment_method': paymentMethod.value.toLowerCase(),
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      categoryId: json['category']['id'], // Extraindo categoria
      accountTypeId: json['account_type']['id'],
      accountTypeName: json['account_type']
          ['name'], // Carregando o nome para exibição
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
