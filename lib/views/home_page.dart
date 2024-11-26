import 'package:novo/views/list_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/auth_controller.dart'; // Controlador de autenticação
import 'add_transaction_page.dart';
import 'login_page.dart'; // Página de login

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionController = Provider.of<TransactionController>(context);
    final authController = Provider.of<AuthController>(context); // Autenticação

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/img/logovertical.png',
          height: 40,
        ),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.signOutAlt,
              color: AppColors.primary,
            ),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sair'),
                  content: const Text('Tem certeza de que deseja sair?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Sair'),
                    ),
                  ],
                ),
              );

              if (confirmed ?? false) {
                await authController.logout(); // Realiza o logout
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                ); // Redireciona para a página de login
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: transactionController.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card para o Saldo
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111827),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.wallet,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Saldo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  'R\$ ${transactionController.totalBalance.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTransactionPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            FontAwesomeIcons.exchangeAlt,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          label: const Text(
                            'Nova Transação',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonPrimary,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Linha com os Cards de Investimento, Receita e Despesa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Card de Investimento
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF111827),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.piggyBank,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'Investimento',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'R\$ ${transactionController.totalInvestment.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Card para Receita
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.chartLine,
                                    color: Colors.green,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'Receita',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'R\$ ${transactionController.totalIncome.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Card para Despesa
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.chartLine,
                                    color: Colors.red,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Text(
                                    'Despesa',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'R\$ -${transactionController.totalExpense.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Botão para acessar a listagem de transações
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: double
                          .infinity, // Faz o botão ocupar toda a largura disponível
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListTransactionPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Ver Todas as Transações',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: AppColors.buttonPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
