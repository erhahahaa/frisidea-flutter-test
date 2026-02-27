enum TransactionType { income, expense }

class Transaction {
  final int? id;
  final String description;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;

  Transaction({
    this.id,
    required this.description,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'category': category,
      'amount': amount,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'date': date.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int?,
      description: map['description'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      type: map['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      date: DateTime.parse(map['date'] as String),
    );
  }

  Transaction copyWith({
    int? id,
    String? description,
    String? category,
    double? amount,
    TransactionType? type,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      description: description ?? this.description,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }
}
