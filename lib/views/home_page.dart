// lib/views/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../controllers/auth_controller.dart';

class Transaction {
  final String title;
  final double amount;
  final String category;

  Transaction({
    required this.title,
    required this.amount,
    required this.category,
  });
}

class TransactionController {
  final List<Transaction> transactions = [
    Transaction(title: 'Transação 1', amount: 100.0, category: 'general'),
    Transaction(title: 'Transação 2', amount: 500.0, category: 'investment'),
    Transaction(title: 'Despesa 1', amount: 50.0, category: 'expense'),
    Transaction(title: 'Investimento 1', amount: 150.0, category: 'investment'),
    Transaction(title: 'Despesa 2', amount: 30.0, category: 'expense'),
    Transaction(title: 'Transação 3', amount: 200.0, category: 'general'),
  ];

  List<Transaction> getLatestTransactions() {
    return transactions.take(3).toList();
  }

  List<Transaction> getLatestInvestments() {
    return transactions
        .where((tx) => tx.category == 'investment')
        .take(3)
        .toList();
  }

  List<Transaction> getLatestExpenses() {
    return transactions
        .where((tx) => tx.category == 'expense')
        .take(3)
        .toList();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget transactionCard(String title, List<Transaction> transactions,
      IconData icon, VoidCallback onSeeAll) {
    return Card(
      margin: const EdgeInsets.all(12),
      color: AppColors.backgroundCard,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,  // Título em branco
                fontSize: 20,          // Título maior
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...transactions.map((transaction) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.primary.withOpacity(0.2),
                        child: Icon(icon, color: AppColors.primary),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontSize: 16,            // Tamanho maior para título da transação
                              fontWeight: FontWeight.bold,
                              color: Colors.white,     // Título em branco
                            ),
                          ),
                          Text(
                            'R\$ ${transaction.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onSeeAll,
                child: const Text(
                  "Ver Todas",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context, listen: false);
    final transactionController = TransactionController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/img/logovertical.png',
          height: 40,
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller.logout();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            color: AppColors.backgroundCard,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 40,
                    color: AppColors.primaryText,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Saldo',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'R\$ 1.234,56',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard(
                    'Investimento', 'R\$ 5.000,00', Icons.savings, Colors.blue),
                _buildSummaryCard(
                    'Receita', 'R\$ 2.500,00', Icons.trending_up, Colors.green),
                _buildSummaryCard(
                    'Despesa', 'R\$ 1.000,00', Icons.trending_down, Colors.red),
              ],
            ),
          ),
          transactionCard(
            'Últimas Transações',
            transactionController.getLatestTransactions(),
            Icons.pix,
            () {
              // Navegar para todas as transações
            },
          ),
          transactionCard(
            'Últimos Investimentos',
            transactionController.getLatestInvestments(),
            Icons.savings,
            () {
              // Navegar para todos os investimentos
            },
          ),
          transactionCard(
            'Últimas Despesas',
            transactionController.getLatestExpenses(),
            Icons.remove,
            () {
              // Navegar para todas as despesas
            },
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: AppColors.primary,
        icon: Icons.add,
        activeIcon: Icons.close,
        iconTheme: const IconThemeData(color: Colors.white),
        spacing: 10,
        spaceBetweenChildren: 10,
        overlayColor: Colors.transparent,
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

  Widget _buildSummaryCard(
      String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Card(
        color: AppColors.backgroundCard,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
             
