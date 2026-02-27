import 'package:flutter/material.dart';
import '../models/transaction.dart' as model;
import '../utils/constants.dart';

class FilterScreen extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final String? initialCategory;
  final model.TransactionType? initialType;

  const FilterScreen({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.initialCategory,
    this.initialType,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedCategory;
  model.TransactionType? _selectedType;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _selectedCategory = widget.initialCategory;
    _selectedType = widget.initialType;
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'startDate': _startDate,
      'endDate': _endDate,
      'category': _selectedCategory,
      'type': _selectedType,
    });
  }

  void _resetFilters() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _selectedCategory = null;
      _selectedType = null;
    });
  }

  List<String> get _allCategories {
    final categories = <String>[];
    categories.addAll(incomeCategories);
    categories.addAll(expenseCategories);
    return categories.toSet().toList()..sort();
  }

  bool get _hasFilters =>
      _startDate != null || _selectedCategory != null || _selectedType != null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter Transactions',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (_hasFilters)
            TextButton(
              onPressed: _resetFilters,
              child: Text(
                'Reset',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Range
            _buildSectionCard(
              context,
              title: 'Date Range',
              icon: Icons.date_range_rounded,
              child: GestureDetector(
                onTap: _selectDateRange,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _startDate != null && _endDate != null
                              ? '${dateFormatter.format(_startDate!)} – ${dateFormatter.format(_endDate!)}'
                              : 'Select date range',
                          style: TextStyle(
                            fontSize: 14,
                            color: _startDate != null
                                ? Colors.grey[800]
                                : Colors.grey[500],
                            fontWeight: _startDate != null
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (_startDate != null)
                        GestureDetector(
                          onTap: () => setState(() {
                            _startDate = null;
                            _endDate = null;
                          }),
                          child: Icon(
                            Icons.close_rounded,
                            size: 18,
                            color: Colors.grey[500],
                          ),
                        )
                      else
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey[400],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Transaction Type
            _buildSectionCard(
              context,
              title: 'Transaction Type',
              icon: Icons.swap_vert_rounded,
              child: Row(
                children: [
                  _buildTypeChip(context, null, 'All'),
                  const SizedBox(width: 8),
                  _buildTypeChip(
                    context,
                    model.TransactionType.income,
                    'Income',
                  ),
                  const SizedBox(width: 8),
                  _buildTypeChip(
                    context,
                    model.TransactionType.expense,
                    'Expense',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Category
            _buildSectionCard(
              context,
              title: 'Category',
              icon: Icons.category_rounded,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildCategoryChip(
                    context,
                    null,
                    'All',
                    Icons.apps_rounded,
                  ),
                  ..._allCategories.map(
                    (cat) => _buildCategoryChip(
                      context,
                      cat,
                      cat,
                      categoryIcons[cat] ?? Icons.category_rounded,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Apply Button
            FilledButton(
              onPressed: _applyFilters,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildTypeChip(
    BuildContext context,
    model.TransactionType? type,
    String label,
  ) {
    final isSelected = _selectedType == type;
    final colorScheme = Theme.of(context).colorScheme;

    Color chipColor = colorScheme.primary;
    if (type == model.TransactionType.income) chipColor = incomeColor;
    if (type == model.TransactionType.expense) chipColor = expenseColor;

    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? chipColor.withValues(alpha: 0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? chipColor : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? chipColor : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String? category,
    String label,
    IconData icon,
  ) {
    final isSelected = _selectedCategory == category;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? colorScheme.primary.withValues(alpha: 0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? colorScheme.primary : Colors.grey[600],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? colorScheme.primary : Colors.grey[600],
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
