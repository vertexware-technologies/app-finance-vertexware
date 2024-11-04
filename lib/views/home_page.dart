// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../utils/app_colors.dart';
import '../controllers/auth_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF111827), // Cor de fundo igual ao login
      appBar: AppBar(
        title: const Text('Página Inicial'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller
                  .logout(); // Chame o método de logout do controlador
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(
                  context, '/login'); // Redireciona para a tela de login
            },
          ),
        ],
      ),
      body: Center(
        child: const Text(
          'Bem-vindo à Página Inicial!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: AppColors.primary,
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.white),
        spacing: 10,
        spaceBetweenChildren: 10,
        overlayColor: Colors.transparent, // Remover fundo branco ao clicar
        children: [
          SpeedDialChild(
            child: const Icon(Icons.compare_arrows, color: Colors.white),
            backgroundColor: Colors.orange,
            label: 'Transferência',
            labelStyle: const TextStyle(color: Colors.white),
            labelBackgroundColor: Colors.orange.withOpacity(0.8),
            onTap: () {
              // Ação para Transferência
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.attach_money, color: Colors.white),
            backgroundColor: Colors.green,
            label: 'Receita',
            labelStyle: const TextStyle(color: Colors.white),
            labelBackgroundColor: Colors.green.withOpacity(0.8),
            onTap: () {
              // Ação para Receita
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.money_off, color: Colors.white),
            backgroundColor: Colors.red,
            label: 'Despesa',
            labelStyle: const TextStyle(color: Colors.white),
            labelBackgroundColor: Colors.red.withOpacity(0.8),
            onTap: () {
              // Ação para Despesa
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
