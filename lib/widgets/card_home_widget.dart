import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../enum/payment_method.dart';
import '../utils/app_colors.dart';

class CardHome extends StatelessWidget {
  final String description;
  final String date;
  final double amount;
  final PaymentMethod methodPayment;
  final int categoryId;
  final int accountTypeId;
  final String accountTypeName;

  const CardHome({
    Key? key,
    required this.description,
    required this.date,
    required this.amount,
    required this.methodPayment,
    required this.categoryId,
    required this.accountTypeId,
    required this.accountTypeName,
  }) : super(key: key);

  IconData _getIconByPaymentMethod(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.PIX:
        return FontAwesomeIcons.pix;
      case PaymentMethod.CARTAO:
        return FontAwesomeIcons.creditCard;
      case PaymentMethod.BOLETO:
        return FontAwesomeIcons.barcode;
      default:
        return FontAwesomeIcons.questionCircle;
    }
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final formatter = DateFormat('dd MMM, yyyy', 'en_US');
      return formatter.format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  TextStyle _getAmountStyle(int categoryId) {
    switch (categoryId) {
      case 1:
        return const TextStyle(
          color: Colors.green,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
      case 2:
        return const TextStyle(
          color: Colors.red,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
      default:
        return const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
    }
  }

  String _getFormattedAmount(double amount, int categoryId) {
    if (categoryId == 2) {
      return '- R\$ ${amount.toStringAsFixed(2)}';
    }
    return 'R\$ ${amount.toStringAsFixed(2)}';
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  accountTypeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  _formatDate(date),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            _getFormattedAmount(amount, categoryId),
            style: _getAmountStyle(categoryId),
          ),
        ],
      ),
    );
  }
}
