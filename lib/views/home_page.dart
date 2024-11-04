// lib/views/home_page.dart

import 'package:flutter/material.dart';
import '../widgets/balance_widget.dart';
import '../widgets/summary_widget.dart';
import '../widgets/transaction_list_widget.dart';
import '../widgets/button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text('Minhas Finanças'),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 100,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bem-vindo ao App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Explore as funcionalidades abaixo',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 208, 206, 206)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BalanceWidget(),
            const SizedBox(height: 20),
            SummaryWidget(),
            const SizedBox(height: 20),
            TransactionListWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegação para outra tela ou ação ao pressionar o botão
          Navigator.pushNamed(context, '/nextPage'); // Ajuste conforme necessário
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
