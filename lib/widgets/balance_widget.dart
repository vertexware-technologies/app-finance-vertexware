import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_balance_wallet, color: Theme.of(context).primaryColor),
            SizedBox(width: 8),
            Text(
              'Saldo Atual',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'R\$ 5.250,00',
              style: TextStyle(fontSize: 28, color: Color(0xFF512DA8)),
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Theme.of(context).primaryColor),
              onPressed: () {
                // Atualizar saldo
              },
            ),
          ],
        ),
      ],
    );
  }
}
