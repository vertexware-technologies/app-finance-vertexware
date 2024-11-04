// lib/main.dart

import 'package:finance_vertexware/views/login_page.dart';
import 'package:finance_vertexware/views/home_page.dart'; // Página inicial a ser criada
import 'package:finance_vertexware/views/register_page.dart';
import 'package:finance_vertexware/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        title: 'Finance - VertexWare',
        debugShowCheckedModeBanner: false,
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
