import 'package:finance_vertexware/views/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/transaction_controller.dart';
import '../widgets/card_transaction.dart';
import '../utils/app_colors.dart';

class ListTransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transações'),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
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
                backgroundColor: AppColors.backgroundCard,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: Consumer<TransactionController>(
        builder: (context, controller, child) {
          if (controller.isLoadingTransactions) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.transactions.isEmpty) {
            return Center(child: Text("Nenhuma transação encontrada"));
          }

          return ListView.builder(
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) {
              final transaction = controller.transactions[index];
              return CardTransaction(
                description: transaction
                    .description, // Caso precise ainda da descrição em algum lugar
                date: transaction.date,
                amount: transaction.amount,
                methodPayment: transaction.paymentMethod,
                categoryId: transaction.categoryId, // Passando o categoryId
                accountTypeId:
                    transaction.accountTypeId, // Passando o accountTypeId
                accountTypeName: transaction.accountTypeName,
              );
            },
          );
        },
      ),
    );
  }
}
