import 'package:finance_vertexware/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Provider.of<AuthController>(context, listen: false)
              .checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (Provider.of<AuthController>(context).isLoggedIn) {
                return const HomePage();
              } else {
                return LoginPage();
              }
            }
          },
        ),
      ),
    );
  }
}
