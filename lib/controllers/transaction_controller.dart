import 'package:novo/models/transaction.dart';
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

  // Lista de transações
  List<Transaction> _transactions = [];
  bool _isLoadingTransactions = false;

  List<Transaction> get transactions => _transactions;
  bool get isLoadingTransactions => _isLoadingTransactions;

  // Construtor para inicializar dados
  TransactionController() {
    fetchData(); // Busca os totais (saldo, investimentos, etc.)
    loadCategories(); // Carrega categorias
    loadAccountTypes(); // Carrega tipos de conta
    loadTransactions(); // Carrega as transações
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
      await loadTransactions(); // Atualiza a lista de transações após adicionar
    } catch (e) {
      print('Erro ao adicionar transação: $e');
      rethrow; // Repassa o erro para tratamento posterior, se necessário
    }
  }

  /// Carrega as últimas transações
  Future<void> loadTransactions() async {
    _isLoadingTransactions = true;
    notifyListeners();

    try {
      _transactions = await _transactionService.fetchTransactions();
      print('Transações carregadas: $_transactions');
    } catch (e) {
      print('Erro ao carregar transações: $e');
    } finally {
      _isLoadingTransactions = false;
      notifyListeners();
    }
  }

  Future<void> editTransaction(Transaction transaction) async {
    try {
      // Chama o serviço para atualizar a transação
      await _transactionService.editTransaction(transaction);
      print('Transação editada com sucesso: $transaction');

      // Atualiza os totais e a lista de transações após a edição
      await fetchData();
      await loadTransactions();
    } catch (e) {
      print('Erro ao editar transação: $e');
      rethrow; // Repassa o erro para tratamento posterior, se necessário
    }
  }

  Future<void> deleteTransaction(int transactionId) async {
    try {
      await _transactionService.deleteTransaction(transactionId);
      _transactions
          .removeWhere((transaction) => transaction.id == transactionId);
      notifyListeners();
    } catch (e) {
      print('Erro ao excluir transação: $e');
      rethrow;
    }
  }

  Future<List<Transaction>> getTransactionsByCategory(int categoryId) async {
    try {
      return await _transactionService.fetchTransactionsByCategory(categoryId);
    } catch (e) {
      print('Erro ao buscar transações por categoria: $e');
      return [];
    }
  }

  Future<List<Transaction>> getTransactionsByAccountType(
      int accountTypeId) async {
    try {
      return await _transactionService
          .fetchTransactionsByAccountType(accountTypeId);
    } catch (e) {
      print('Erro ao buscar transações por tipo de conta: $e');
      return [];
    }
  }
}
