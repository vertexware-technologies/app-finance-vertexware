import 'package:novo/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../utils/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.background, // Fundo preto
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo-nome.png', // Ajuste o caminho da imagem
                width: 180,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard, // Fundo cinza escuro
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: emailController,
                      icon: Icons.email,
                      label: 'Email',
                      validator: emailValidator,
                      fillColor: AppColors.background, // Fundo do campo
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: 'Password',
                      isSecret: true,
                      validator: passwordValidator,
                      fillColor: AppColors.background, // Fundo do campo
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget(
                      onPressed: () async {
                        try {
                          await controller.login(
                            emailController.text,
                            passwordController.text,
                          );

                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(context, '/home');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erro ao tentar fazer login!"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: AppColors.buttonPrimary, // Cor do botão
                    ),
                    const SizedBox(
                        height: 20), // Espaço entre o botão e o texto
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/register'); // Navegar para a tela de registro
                      },
                      child: Text(
                        'Ainda não está registrado?',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                          decoration:
                              TextDecoration.underline, // Texto sublinhado
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
