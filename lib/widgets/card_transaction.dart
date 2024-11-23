import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../enum/payment_method.dart';
import '../utils/app_colors.dart';

class CardTransaction extends StatelessWidget {
  final String description;
  final String date;
  final double amount;
  final PaymentMethod methodPayment;
  final int categoryId;
  final int accountTypeId;
  final String accountTypeName; // Novo campo para o nome do tipo de conta

  const CardTransaction({
    Key? key,
    required this.description,
    required this.date,
    required this.amount,
    required this.methodPayment,
    required this.categoryId,
    required this.accountTypeId,
    required this.accountTypeName, // Passando accountTypeName
  }) : super(key: key);

  // Função para retornar o ícone correspondente ao método de pagamento
  IconData _getIconByPaymentMethod(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.PIX:
        return FontAwesomeIcons.pix;
      case PaymentMethod.CARTAO:
        return FontAwesomeIcons.creditCard;
      case PaymentMethod.BOLETO:
        return FontAwesomeIcons.barcode;
      default:
        return FontAwesomeIcons.questionCircle; // Ícone padrão
    }
  }

  // Função para formatar a data no formato "22 Nov, 2024"
  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final formatter =
          DateFormat('dd MMM, yyyy', 'en_US'); // Formato com mês abreviado
      return formatter.format(parsedDate);
    } catch (e) {
      return date; // Retorna a data original caso ocorra erro
    }
  }

  // Função para determinar o estilo do valor com base no categoryId
  TextStyle _getAmountStyle(int categoryId) {
    switch (categoryId) {
      case 1: // Receita
        return const TextStyle(
          color: Colors.green,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
      case 2: // Despesa
        return const TextStyle(
          color: Colors.red,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
      case 3: // Investimento
      default:
        return const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
    }
  }

  // Função para retornar o valor formatado com base no categoryId
  String _getFormattedAmount(double amount, int categoryId) {
    if (categoryId == 2) {
      return '- R\$ ${amount.toStringAsFixed(2)}'; // Despesa
    }
    return 'R\$ ${amount.toStringAsFixed(2)}'; // Receita ou Investimento
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ícone do método de pagamento
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              _getIconByPaymentMethod(methodPayment),
              color: Colors.white,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 12.0),

          // Exibindo o accountTypeName
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountTypeName, // Exibe o accountTypeName
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  _formatDate(date), // Formata a data
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8.0),

          // Valor da transação
          Text(
            _getFormattedAmount(amount, categoryId), // Valor formatado
            style: _getAmountStyle(categoryId), // Estilo condicional
          ),

          const SizedBox(width: 8.0),

          // Botão de opções (Editar e Excluir)
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                // Lógica para editar (implemente depois)
                print('Editar clicado!');
              } else if (value == 'delete') {
                // Lógica para excluir (implemente depois)
                print('Excluir clicado!');
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            color: AppColors.background,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: const [
                    Icon(Icons.edit, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      'Editar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: const [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Excluir',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
