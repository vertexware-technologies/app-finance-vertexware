import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.attach_money, color: Color(0xFF512DA8)),
            title: Text('Salário'),
            subtitle: Text('10/10/2024'),
            trailing: Text(
              '+ R\$ 3.500,00',
              style: TextStyle(color: Color(0xFF512DA8), fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart, color: Color(0xFFF57C00)),
            title: Text('Supermercado'),
            subtitle: Text('05/10/2024'),
            trailing: Text(
              '- R\$ 450,00',
              style: TextStyle(color: Color(0xFFF57C00), fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Color(0xFFF57C00)),
            title: Text('Aluguel'),
            subtitle: Text('01/10/2024'),
            trailing: Text(
              '- R\$ 1.200,00',
              style: TextStyle(color: Color(0xFFF57C00), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
