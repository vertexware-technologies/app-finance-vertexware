import 'package:finance_vertexware/models/transaction.dart';
import 'package:flutter/material.dart';
import '../services/transaction_service.dart';

class TransactionController extends ChangeNotifier {
  // Dados principais
  double _totalBalance = 0.0;
  double _totalInvestment = 0.0;
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;

  // Estado de carregamento
  bool _isLoading = false;

  // Getters para os dados principais
  double get totalBalance => _totalBalance;
  double get totalInvestment => _totalInvestment;
  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;

  // Getters para o estado de carregamento
  bool get isLoading => _isLoading;

  // Serviço responsável pelas requisições
  final TransactionService _transactionService = TransactionService();

  // Dados das categorias
  List<Map<String, dynamic>> _categories = [];
  bool _isLoadingCategories = false;

  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoadingCategories => _isLoadingCategories;

  // Dados dos tipos de conta
  List<Map<String, dynamic>> _accountTypes = [];
  bool _isLoadingAccountTypes = false;

  List<Map<String, dynamic>> get accountTypes => _accountTypes;
  bool get isLoadingAccountTypes => _isLoadingAccountTypes;

  // Construtor para inicializar dados
  TransactionController() {
    fetchData(); // Busca os totais (saldo, investimentos, etc.)
    loadCategories(); // Carrega categorias
    loadAccountTypes(); // Carrega tipos de conta
  }

  /// Busca os totais de saldo, investimentos, receitas e despesas
  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Realiza múltiplas requisições simultaneamente
      var results = await Future.wait([
        _transactionService.fetchTotalBalance(),
        _transactionService.fetchTotalInvestments(),
        _transactionService.fetchTotalIncome(),
        _transactionService.fetchTotalExpenses(),
      ]);

      // Atualiza os valores recebidos
      _totalBalance = results[0];
      _totalInvestment = results[1];
      _totalIncome = results[2];
      _totalExpense = results[3];
    } catch (e) {
      print('Erro ao buscar dados: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    _isLoadingCategories = true;
    notifyListeners();

    try {
      _categories = await _transactionService.fetchCategories();
      print('Categorias carregadas: $_categories');
    } catch (e) {
      print('Erro ao carregar categorias: $e');
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  /// Carrega os tipos de conta disponíveis
  Future<void> loadAccountTypes() async {
    _isLoadingAccountTypes = true;
    notifyListeners();

    try {
      _accountTypes = await _transactionService.fetchAccountTypes();
    } catch (e) {
      print('Erro ao carregar tipos de conta: $e');
    } finally {
      _isLoadingAccountTypes = false;
      notifyListeners();
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      final newTransaction =
          await _transactionService.addTransaction(transaction);

      print('Transação adicionada: $newTransaction');

      // Atualiza os totais e listas após adicionar a transação
      await fetchData();
    } catch (e) {
      print('Erro ao adicionar transação: $e');
      rethrow; // Repassa o erro para tratamento posterior, se necessário
    }
  }
}
