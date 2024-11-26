import 'package:novo/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:novo/controllers/auth_controller.dart';
import 'package:novo/controllers/transaction_controller.dart';
import 'package:novo/services/auth_service.dart';

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
        initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}
