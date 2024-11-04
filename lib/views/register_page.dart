// lib/views/register_page.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/text_field_widget.dart'; // Reutilizando o TextFieldWidget

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827), // Cor de fundo igual ao login
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(
              controller: nameController,
              icon: Icons.person,
              label: 'Nome',
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: emailController,
              icon: Icons.email,
              label: 'Email',
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
              controller: passwordController,
              icon: Icons.lock,
              label: 'Senha',
              isSecret: true,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Função de cadastro aqui
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.buttonPrimary),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
