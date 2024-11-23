import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../models/user.dart';
import '../utils/app_colors.dart';
import '../utils/validators.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  RegisterPage({super.key});

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
                      controller: nameController,
                      icon: Icons.person,
                      label: 'Nome',
                      validator: nameValidator,
                      fillColor: AppColors.background, // Fundo do campo
                    ),
                    const SizedBox(height: 10),
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
                      label: 'Senha',
                      isSecret: true,
                      validator: passwordValidator,
                      fillColor: AppColors.background, // Fundo do campo
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: passwordConfirmationController,
                      icon: Icons.lock,
                      label: 'Confirmar Senha',
                      isSecret: true,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'As senhas não correspondem';
                        }
                        return null;
                      },
                      fillColor: AppColors.background, // Fundo do campo
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget(
                      onPressed: () async {
                        try {
                          final user = User(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          await controller.register(
                            user,
                            passwordConfirmationController.text,
                          );

                          if (!context.mounted) return;

                          // Mensagem de sucesso
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Registro realizado com sucesso!'),
                            ),
                          );

                          // Redireciona para a página de login
                          Navigator.pushReplacementNamed(context, '/login');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erro ao tentar registrar: $e"),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: AppColors.buttonPrimary, // Cor do botão
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Já possui uma conta? Faça login',
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
