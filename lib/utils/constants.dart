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

// Category icons
const Map<String, IconData> categoryIcons = {
  'Salary': Icons.work_rounded,
  'Business': Icons.business_center_rounded,
  'Food': Icons.restaurant_rounded,
  'Transport': Icons.directions_car_rounded,
  'Bills': Icons.receipt_long_rounded,
  'Shopping': Icons.shopping_bag_rounded,
  'Entertainment': Icons.movie_rounded,
  'Other': Icons.more_horiz_rounded,
};

// Color constants
const Color incomeColor = Color(0xFF2E7D32); // green[800]
const Color expenseColor = Color(0xFFC62828); // red[800]
const Color incomeColorLight = Color(0xFFE8F5E9); // green[50]
const Color expenseColorLight = Color(0xFFFFEBEE); // red[50]

// Gradient for balance card
const List<Color> balanceCardGradient = [
  Color(0xFF004D40), // teal[900]
  Color(0xFF00796B), // teal[700]
  Color(0xFF26A69A), // teal[400]
];

// Currency formatter for Indonesian Rupiah
final NumberFormat currencyFormatter = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);

// Date formatter
final DateFormat dateFormatter = DateFormat('dd MMM yyyy', 'id_ID');
final DateFormat dateTimeFormatter = DateFormat('dd MMM yyyy HH:mm', 'id_ID');
