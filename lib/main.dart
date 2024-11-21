import 'package:finance_vertexware/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_vertexware/controllers/auth_controller.dart';
import 'package:finance_vertexware/controllers/transaction_controller.dart';
import 'package:finance_vertexware/services/auth_service.dart';
import 'app_routes.dart'; // Importando as rotas centralizadas

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await AuthService().getToken() != null; // Verificar login
  runApp(MyApp(isLoggedIn: isLoggedIn));
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
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        initialRoute: isLoggedIn
            ? AppRoutes.home
            : AppRoutes.welcome, // Usando rotas centralizadas
        routes: AppRoutes.routes, // Rotas definidas no arquivo separado
      ),
    );
  }
}
