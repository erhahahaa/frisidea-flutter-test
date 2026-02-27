import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Income categories
const List<String> incomeCategories = ['Salary', 'Business', 'Other'];

// Expense categories
const List<String> expenseCategories = [
  'Food',
  'Transport',
  'Bills',
  'Shopping',
  'Entertainment',
  'Other',
];

// Color constants
const Color incomeColor = Colors.green;
const Color expenseColor = Colors.red;

// Currency formatter for Indonesian Rupiah
final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

// Date formatter
final DateFormat dateFormatter = DateFormat('dd MMM yyyy', 'id_ID');
final DateFormat dateTimeFormatter = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
