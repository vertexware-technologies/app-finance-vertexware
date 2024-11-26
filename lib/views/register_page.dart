import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../models/user.dart';
import '../utils/app_colors.dart';
import '../utils/validator_register.dart';
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
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo-nome.png',
                width: 180,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: nameController,
                      icon: Icons.person,
                      label: 'Nome',
                      validator: ValidatorRegister.validateName,
                      fillColor: AppColors.background,
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: emailController,
                      icon: Icons.email,
                      label: 'Email',
                      validator: ValidatorRegister.validateEmail,
                      fillColor: AppColors.background,
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: passwordController,
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                      validator: ValidatorRegister.validatePassword,
                      fillColor: AppColors.background,
                    ),
                    const SizedBox(height: 10),
                    TextFieldWidget(
                      controller: passwordConfirmationController,
                      icon: Icons.lock,
                      label: 'Confirmar Senha',
                      isSecret: true,
                      validator: (value) =>
                          ValidatorRegister.validatePasswordConfirmation(
                        value,
                        passwordController.text,
                      ),
                      fillColor: AppColors.background,
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

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Registro realizado com sucesso!',
                                style: TextStyle(color: AppColors.white),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 3),
                            ),
                          );

                          Navigator.pushReplacementNamed(context, '/login');
                        } catch (e) {
                          final errorMessage =
                              e.toString().replaceAll('Exception: ', '');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(errorMessage),
                              backgroundColor: Colors.red,
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
                      color: AppColors.buttonPrimary,
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
                          decoration: TextDecoration.underline,
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
