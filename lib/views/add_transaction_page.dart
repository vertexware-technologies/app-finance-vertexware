import 'package:flutter/material.dart';
import 'package:finance_vertexware/controllers/transaction_controller.dart';
import 'package:finance_vertexware/utils/app_colors.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCategory;
  String? _selectedAccountType;
  DateTime? _transactionDate;
  String? _paymentMethod;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final transactionController =
        Provider.of<TransactionController>(context, listen: false);
    transactionController.loadCategories();
    transactionController.loadAccountTypes();
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdownField(
                  label: 'Categoria',
                  value: _selectedCategory,
                  items: transactionController.categories,
                  isLoading: transactionController.isLoadingCategories,
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value),
                  validator: (value) =>
                      value == null ? 'Selecione uma categoria' : null,
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'Tipo de Conta',
                  value: _selectedAccountType,
                  items: transactionController.accountTypes,
                  isLoading: transactionController.isLoadingAccountTypes,
                  onChanged: (value) =>
                      setState(() => _selectedAccountType = value),
                  validator: (value) =>
                      value == null ? 'Selecione um tipo de conta' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Descrição',
                  validator: (value) =>
                      value!.isEmpty ? 'Por favor, insira uma descrição' : null,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _amountController,
                  label: 'Valor',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira um valor';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildDatePickerField(
                  label: 'Data',
                  selectedDate: _transactionDate,
                  onDateSelected: (pickedDate) =>
                      setState(() => _transactionDate = pickedDate),
                ),
                const SizedBox(height: 16),
                _buildDropdownField(
                  label: 'Método de Pagamento',
                  value: _paymentMethod,
                  items: [
                    {'id': 'Pix', 'name': 'Pix'},
                    {'id': 'Cartão', 'name': 'Cartão'},
                    {'id': 'Boleto', 'name': 'Boleto'},
                  ],
                  isLoading: false,
                  onChanged: (value) => setState(() => _paymentMethod = value),
                  validator: (value) =>
                      value == null ? 'Selecione um método de pagamento' : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            final transaction = {
                              'category_id': _selectedCategory,
                              'account_type_id': _selectedAccountType,
                              'description': _descriptionController.text,
                              'amount': double.parse(_amountController.text),
                              'date': _transactionDate?.toIso8601String(),
                              'payment_method': _paymentMethod,
                            };

                            try {
                              await transactionController
                                  .addTransaction(transaction);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Transação adicionada!'),
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao adicionar: $e'),
                                ),
                              );
                            } finally {
                              setState(() => _isLoading = false);
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
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<Map<String, dynamic>> items,
    required bool isLoading,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item['id'].toString(),
                      child: Text(item['name']),
                    ))
                .toList(),
            onChanged: onChanged,
            validator: validator,
          );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? selectedDate,
    required void Function(DateTime) onDateSelected,
  }) {
    return TextFormField(
      readOnly: true,
      controller: TextEditingController(
        text: selectedDate != null
            ? '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}'
            : '',
      ),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      validator: (value) => selectedDate == null ? 'Selecione uma data' : null,
    );
  }
}
