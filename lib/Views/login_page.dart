import 'package:finance_vertexware/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await controller.login(
                    emailController.text,
                    passwordController.text,
                  );

                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Erro ao tentar fazer login!")),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
