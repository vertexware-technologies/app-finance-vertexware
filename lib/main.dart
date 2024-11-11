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
      .ensureInitialized(); // Garantir que a inicialização dos plugins seja feita antes
  final isLoggedIn = await AuthService().getToken() !=
      null; // Verificar se o usuário está logado
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
      ],
      child: MaterialApp(
        title: 'Finance - VertexWare',
        debugShowCheckedModeBanner: false,
        initialRoute: isLoggedIn
            ? '/home'
            : '/welcome', // Define a página inicial com base no login
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
