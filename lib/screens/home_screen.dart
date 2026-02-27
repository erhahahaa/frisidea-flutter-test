import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/transaction.dart' as model;
import '../widgets/balance_card.dart';
import '../widgets/transaction_card.dart';
import 'add_transaction_screen.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<model.Transaction> _transactions = [];
  double _balance = 0.0;
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  bool _isLoading = true;

  // Filter parameters
  DateTime? _filterStartDate;
  DateTime? _filterEndDate;
  String? _filterCategory;
  model.TransactionType? _filterType;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<model.Transaction> transactions;

      if (_filterStartDate != null ||
          _filterCategory != null ||
          _filterType != null) {
        transactions = await _dbHelper.getFilteredTransactions(
          startDate: _filterStartDate,
          endDate: _filterEndDate,
          category: _filterCategory,
          type: _filterType,
        );
      } else {
        transactions = await _dbHelper.getTransactions();
      }

      final balance = await _dbHelper.getBalance();
      final income = await _dbHelper.getTotalIncome();
      final expense = await _dbHelper.getTotalExpense();

      setState(() {
        _transactions = transactions;
        _balance = balance;
        _totalIncome = income;
        _totalExpense = expense;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading data: $e')));
      }
    }
  }

  Future<void> _deleteTransaction(int id) async {
    try {
      await _dbHelper.deleteTransaction(id);
      _loadData();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Transaction deleted')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting transaction: $e')),
        );
      }
    }
  }

  Future<void> _navigateToAddTransaction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
    );

    if (result == true) {
      _loadData();
    }
  }

  Future<void> _navigateToFilter() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(
          initialStartDate: _filterStartDate,
          initialEndDate: _filterEndDate,
          initialCategory: _filterCategory,
          initialType: _filterType,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _filterStartDate = result['startDate'] as DateTime?;
        _filterEndDate = result['endDate'] as DateTime?;
        _filterCategory = result['category'] as String?;
        _filterType = result['type'] as model.TransactionType?;
      });
      _loadData();
    }
  }

  void _clearFilters() {
    setState(() {
      _filterStartDate = null;
      _filterEndDate = null;
      _filterCategory = null;
      _filterType = null;
    });
    _loadData();
  }

  bool get _hasActiveFilters =>
      _filterStartDate != null ||
      _filterCategory != null ||
      _filterType != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencatatan Keuangan'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: _hasActiveFilters ? Colors.blue : null,
            ),
            onPressed: _navigateToFilter,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  BalanceCard(
                    balance: _balance,
                    totalIncome: _totalIncome,
                    totalExpense: _totalExpense,
                  ),
                  if (_hasActiveFilters)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_alt, size: 16),
                          const SizedBox(width: 8),
                          const Text('Filters active'),
                          const Spacer(),
                          TextButton(
                            onPressed: _clearFilters,
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: _transactions.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 80,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No transactions yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap + to add your first transaction',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = _transactions[index];
                              return TransactionCard(
                                transaction: transaction,
                                onDelete: () =>
                                    _deleteTransaction(transaction.id!),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTransaction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
