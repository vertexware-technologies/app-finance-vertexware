import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novo/utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../controllers/transaction_controller.dart';
import '../enum/payment_method.dart';

class EditTransactionPage extends StatefulWidget {
  final Transaction transaction;

  const EditTransactionPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  int? _categoryId;
  int? _accountTypeId;
  String? _description;
  double? _amount;
  PaymentMethod? _paymentMethod;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Inicializando os campos com os valores da transação existente
    _categoryId = widget.transaction.categoryId;
    _accountTypeId = widget.transaction.accountTypeId;
    _description = widget.transaction.description;
    _amount = widget.transaction.amount;
    _paymentMethod = widget.transaction.paymentMethod;
    _selectedDate =
        DateTime.parse(widget.transaction.date); // Conversão da data
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TransactionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Transação'),
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(
          color: AppColors.black,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppColors.backgroundCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Dropdown para Categoria
                      DropdownButtonFormField<int>(
                        value: _categoryId,
                        onChanged: (value) =>
                            setState(() => _categoryId = value),
                        items: controller.categories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category['id'],
                            child: Text(
                              category['name'],
                              style: TextStyle(color: AppColors.white),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                          labelStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.backgroundCard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        dropdownColor: AppColors.backgroundCard,
                        hint: Text(
                          'Selecione',
                          style: TextStyle(color: AppColors.white),
                        ),
                        validator: (value) =>
                            value == null ? 'Selecione uma categoria' : null,
                      ),
                      const SizedBox(height: 16), // Espaçamento entre os campos

                      // Dropdown para Tipo de Conta
                      DropdownButtonFormField<int>(
                        value: _accountTypeId,
                        onChanged: (value) =>
                            setState(() => _accountTypeId = value),
                        items: controller.accountTypes.map((accountType) {
                          return DropdownMenuItem<int>(
                            value: accountType['id'],
                            child: Text(
                              accountType['name'],
                              style: TextStyle(color: AppColors.white),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Tipo de Conta',
                          labelStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.backgroundCard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        dropdownColor: AppColors.backgroundCard,
                        hint: Text(
                          'Selecione',
                          style: TextStyle(color: AppColors.white),
                        ),
                        validator: (value) =>
                            value == null ? 'Selecione um tipo de conta' : null,
                      ),
                      const SizedBox(height: 16), // Espaçamento entre os campos

                      // Campo para Descrição
                      TextFormField(
                        initialValue: _description,
                        decoration: InputDecoration(
                          labelText: 'Descrição',
                          labelStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.backgroundCard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        style: TextStyle(color: AppColors.white),
                        onChanged: (value) => _description = value,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Informe a descrição'
                            : null,
                      ),
                      const SizedBox(height: 16), // Espaçamento entre os campos

                      // Campo para Valor
                      TextFormField(
                        initialValue: _amount?.toString(),
                        decoration: InputDecoration(
                          labelText: 'Valor',
                          labelStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.backgroundCard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        style: TextStyle(color: AppColors.white),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d*'),
                          ),
                        ],
                        onChanged: (value) => _amount = double.tryParse(value),
                        validator: (value) =>
                            value == null || double.tryParse(value) == null
                                ? 'Informe um valor válido'
                                : null,
                      ),
                      const SizedBox(height: 16), // Espaçamento entre os campos

                      // Dropdown para Método de Pagamento
                      DropdownButtonFormField<PaymentMethod>(
                        value: _paymentMethod,
                        onChanged: (value) =>
                            setState(() => _paymentMethod = value),
                        items: PaymentMethod.values.map((method) {
                          return DropdownMenuItem<PaymentMethod>(
                            value: method,
                            child: Text(
                              method.value,
                              style: TextStyle(color: AppColors.white),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Método de Pagamento',
                          labelStyle: TextStyle(color: AppColors.white),
                          filled: true,
                          fillColor: AppColors.backgroundCard,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        dropdownColor: AppColors.backgroundCard,
                        hint: Text(
                          'Selecione',
                          style: TextStyle(color: AppColors.white),
                        ),
                        validator: (value) => value == null
                            ? 'Selecione um método de pagamento'
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24), // Espaçamento entre o Card e o botão

            // Botão para salvar
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final updatedTransaction = Transaction(
                    id: widget.transaction.id,
                    categoryId: _categoryId!,
                    accountTypeId: _accountTypeId!,
                    accountTypeName:
                        "", // O nome pode ser vazio ou você pode preencher conforme a necessidade
                    description: _description!,
                    amount: _amount!,
                    date: _selectedDate.toIso8601String().split('T')[0],
                    paymentMethod: _paymentMethod!,
                  );

                  try {
                    await controller.editTransaction(
                        updatedTransaction); // Edita a transação
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Transação atualizada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop(); // Retorna à tela anterior
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao atualizar transação: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                foregroundColor: AppColors.white,
                shadowColor: AppColors.hoverActive,
              ).copyWith(
                overlayColor: MaterialStateProperty.all(AppColors.hoverActive),
              ),
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
