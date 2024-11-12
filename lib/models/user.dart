import 'package:finance_vertexware/models/transaction.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password; // Optional if you manage authentication locally
  final List<Transaction>? transactions;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.transactions,
  });

  // Factory method to create a User from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'] ?? '',
      transactions: json['transactions'] != null
          ? (json['transactions'] as List)
              .map((tx) => Transaction.fromJson(tx))
              .toList()
          : null,
    );
  }

  // Method to convert User to JSON for API usage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'transactions': transactions?.map((tx) => tx.toJson()).toList(),
    };
  }
}
