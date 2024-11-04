// lib/views/welcome_page.dart

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827), // Cor de fundo igual ao login
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo.png', // Caminho da imagem, igual ao login
              width: 150,
            ),
            const SizedBox(height: 50),
            const Text(
              'Bem-vindo ao Meu App!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            const Text(
              'Escolha uma opção para continuar:',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
            16, 0, 16, 30), // Margem inferior ajustada
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Ajusta a altura para ocupar apenas o espaço necessário
          children: [
            // Botão de Register
            SizedBox(
              width: double.infinity, // Ocupa a largura total
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(AppColors.buttonPrimary),
                  side: MaterialStateProperty.all(
                    BorderSide(color: AppColors.buttonPrimary),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => states.contains(MaterialState.hovered)
                        ? AppColors.buttonPrimary
                        : Colors.transparent,
                  ),
                  overlayColor: MaterialStateProperty.all(
                      AppColors.buttonPrimary.withOpacity(0.1)),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20)),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 10), // Espaço entre os botões
            // Botão de Login
            SizedBox(
              width: double.infinity, // Ocupa a largura total
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(
                            0xFF5C5495); // Lilás mais escuro ao pressionar
                      }
                      return const Color(0xFF726AB4);
                    },
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.white12),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 20)),
                ),
                child: const Text(
                  'Login',
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
