import 'package:finance_vertexware/controllers/transaction_controller.dart';
import 'package:finance_vertexware/utils/app_colors.dart';
import 'package:finance_vertexware/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedAccountType;
  double? _amount;
  DateTime? _transactionDate;
  String? _paymentMethod;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<TransactionController>(context, listen: false).loadCategories();
    Provider.of<TransactionController>(context, listen: false)
        .loadAccountTypes();
  }

  @override
  Widget build(BuildContext context) {
    final transactionController = Provider.of<TransactionController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Adicionar Transação'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seleção de Categoria
              transactionController.isLoadingCategories
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      items: transactionController.categories
                          .map((category) => DropdownMenuItem<String>(
                                value: category['id'].toString(),
                                child: Text(category['name']),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null ? 'Selecione uma categoria' : null,
                    ),
              const SizedBox(height: 16),

              // Seleção de Tipo de Conta
              transactionController.isLoadingAccountTypes
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                      value: _selectedAccountType,
                      onChanged: (value) {
                        setState(() {
                          _selectedAccountType = value;
                        });
                      },
                      items: transactionController.accountTypes
                          .map((accountType) => DropdownMenuItem<String>(
                                value: accountType['id'].toString(),
                                child: Text(accountType['name']),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Conta',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null ? 'Selecione um tipo de conta' : null,
                    ),
              const SizedBox(height: 16),

              // Campo de Descrição
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Insira uma descrição'
                    : null,
              ),
              const SizedBox(height: 16),

              // Campo de Valor
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Valor inválido';
                  }
                  _amount = double.tryParse(value);
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de Data
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                    text: _transactionDate != null
                        ? _transactionDate!.toLocal().toString().split(' ')[0]
                        : ''),
                decoration: const InputDecoration(
                  labelText: 'Data',
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _transactionDate)
                    setState(() {
                      _transactionDate = pickedDate;
                    });
                },
              ),
              const SizedBox(height: 16),

              // Seleção de Método de Pagamento
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
                items: ['Pix', 'Cartão', 'Boleto']
                    .map((paymentMethod) => DropdownMenuItem<String>(
                          value: paymentMethod,
                          child: Text(paymentMethod),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Método de Pagamento',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null ? 'Selecione um método de pagamento' : null,
              ),
              const SizedBox(height: 16),

              // Botão de Adicionar
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            final transaction = {
                              'category_id': _selectedCategory,
                              'account_type_id': _selectedAccountType,
                              'description': _descriptionController.text,
                              'amount': _amount,
                              'date': _transactionDate?.toIso8601String(),
                              'payment_method': _paymentMethod,
                            };

                            await transactionController
                                .addTransaction(transaction);

                            // Sucesso! Voltar para a página inicial
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro: $e')),
                            );
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Adicionar Transação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
