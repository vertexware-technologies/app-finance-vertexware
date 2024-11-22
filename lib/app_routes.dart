import 'package:finance_vertexware/views/add_transaction_page.dart';
import 'package:finance_vertexware/views/login_page.dart';
import 'package:finance_vertexware/views/home_page.dart';
import 'package:finance_vertexware/views/register_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addTransaction = '/add-transaction';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => LoginPage(),
      register: (context) => RegisterPage(),
      home: (context) => HomePage(),
      addTransaction: (context) => AddTransactionPage(),
    };
  }
}
