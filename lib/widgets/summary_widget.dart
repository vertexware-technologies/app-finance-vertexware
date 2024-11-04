import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bar_chart, color: Theme.of(context).primaryColor),
            SizedBox(width: 8),
            Text(
              'Resumo Mensal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Gráfico de receitas/despesas',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ),
      ],
    );
  }
}
