import 'package:novo/views/add_transaction_page.dart';
import 'package:novo/views/login_page.dart';
import 'package:novo/views/home_page.dart';
import 'package:novo/views/register_page.dart';
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
