import 'package:finance_vertexware/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  Future<void> _submitForm(
      BuildContext context, AuthController authController) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await authController.register();
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (error) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Erro'),
            content: const Text('Ocorreu um erro ao registrar.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Ok'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthController>(
          builder: (ctx, authController, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authController.user?.name = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Por favor, insira um email válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authController.user?.email = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authController.user?.password = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  authController.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _submitForm(context, authController),
                          child: const Text('Registrar'),
                        ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: const Text('Já tem uma conta? Login'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
