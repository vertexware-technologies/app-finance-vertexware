import 'package:flutter/material.dart';
import '../services/transaction_service.dart';

class TransactionController extends ChangeNotifier {
  // Atributos para valores financeiros
  double _totalBalance = 0.0;
  double _totalInvestment = 0.0;
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  bool _isLoading = false;

  double get totalBalance => _totalBalance;
  double get totalInvestment => _totalInvestment;
  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;
  bool get isLoading => _isLoading;

  // Atributos para categorias
  List<Map<String, dynamic>> _categories = [];
  bool _isLoadingCategories = false;

  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoadingCategories => _isLoadingCategories;

  final TransactionService _transactionService = TransactionService();

  TransactionController() {
    fetchData();
    loadCategories();
    loadAccountTypes();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      var results = await Future.wait([
        _transactionService.fetchTotalBalance(),
        _transactionService.fetchTotalInvestments(),
        _transactionService.fetchTotalIncome(),
        _transactionService.fetchTotalExpenses(),
      ]);

      _totalBalance = results[0];
      _totalInvestment = results[1];
      _totalIncome = results[2];
      _totalExpense = results[3];
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCategories() async {
    _isLoadingCategories = true;
    notifyListeners();

    try {
      _categories = await _transactionService.fetchCategories();
      print('Categorias carregadas: $_categories');
    } catch (e) {
      print('Erro ao carregar categorias: $e');
    }

    _isLoadingCategories = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> _accountTypes = [];
  bool _isLoadingAccountTypes = false;

  List<Map<String, dynamic>> get accountTypes => _accountTypes;
  bool get isLoadingAccountTypes => _isLoadingAccountTypes;

  Future<void> loadAccountTypes() async {
    _isLoadingAccountTypes = true;
    notifyListeners();

    try {
      _accountTypes = await _transactionService.fetchAccountTypes();
    } catch (e) {
      print('Erro ao carregar tipos de conta: $e');
    }

    _isLoadingAccountTypes = false;
    notifyListeners();
  }

  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    final transactionService = TransactionService();
    await transactionService.addTransaction(transaction);
    notifyListeners();
  }
}
