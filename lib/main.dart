import 'package:finance_vertexware/controllers/transaction_controller.dart';
import 'package:finance_vertexware/views/add_transaction_page.dart';
import 'package:finance_vertexware/views/login_page.dart';
import 'package:finance_vertexware/views/home_page.dart';
import 'package:finance_vertexware/views/register_page.dart';
import 'package:finance_vertexware/views/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garantir a inicialização correta dos plugins
  final isLoggedIn = await AuthService().getToken() != null; // Verificar login
  runApp(MyApp(isLoggedIn: isLoggedIn)); // Passar o estado de login para o app
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => TransactionController()),
      ],
      child: MaterialApp(
        title: 'Finance - VertexWare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor:
              const Color(0xFFF5F5F5), // Definição de fundo global
        ),
        initialRoute: isLoggedIn
            ? '/home'
            : '/welcome', // Página inicial baseada no login
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/add-transaction': (context) => AddTransactionPage(),
        },
      ),
    );
  }
}
