import 'package:finance_vertexware/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../controllers/transaction_controller.dart';
import '../enum/payment_method.dart';

class AddTransactionPage extends StatefulWidget {
  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  int? _categoryId;
  int? _accountTypeId;
  String? _description;
  double? _amount;
  PaymentMethod _paymentMethod = PaymentMethod.PIX;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TransactionController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Transação')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<int>(
                value: _categoryId,
                onChanged: (value) => setState(() => _categoryId = value),
                items: controller.categories.map((category) {
                  return DropdownMenuItem<int>(
                    value: category['id'],
                    child: Text(category['name']),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Categoria'),
                validator: (value) =>
                    value == null ? 'Selecione uma categoria' : null,
              ),
              DropdownButtonFormField<int>(
                value: _accountTypeId,
                onChanged: (value) => setState(() => _accountTypeId = value),
                items: controller.accountTypes.map((accountType) {
                  return DropdownMenuItem<int>(
                    value: accountType['id'],
                    child: Text(accountType['name']),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Tipo de Conta'),
                validator: (value) =>
                    value == null ? 'Selecione um tipo de conta' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => _description = value,
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a descrição'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _amount = double.tryParse(value ?? ''),
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Informe um valor válido'
                        : null,
              ),
              DropdownButtonFormField<PaymentMethod>(
                value: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
                items: PaymentMethod.values.map((method) {
                  return DropdownMenuItem<PaymentMethod>(
                    value: method,
                    child: Text(method.value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: 'Método de Pagamento'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newTransaction = Transaction(
                      categoryId: _categoryId!,
                      accountTypeId: _accountTypeId!,
                      description: _description!,
                      amount: _amount!,
                      date: _selectedDate.toIso8601String().split('T')[0],
                      paymentMethod: _paymentMethod,
                    );

                    try {
                      await controller.addTransaction(newTransaction);

                      // Exibir mensagem de sucesso
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Transação salva com sucesso!')),
                      );

                      // Redirecionar para a página inicial
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.home,
                        (route) => false, // Remove todas as rotas anteriores
                      );
                    } catch (e) {
                      // Exibir mensagem de erro
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro ao salvar transação: $e')),
                      );
                    }
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
