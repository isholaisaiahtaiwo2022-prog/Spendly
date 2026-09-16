enum TransactionType { expense, income }

class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final TransactionType type;
  final String? paymentMethod;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.type = TransactionType.expense,
    this.paymentMethod,
  });

  // Serialize Expense instance to Map

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'type': type.name,
      'paymentMethod': paymentMethod,
    };
  }

  // Deserialize Map Expanse  insatance
  factory Expense.fromMap(Map map) {
    return Expense(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] ?? 'General',
      date: DateTime.parse(map['date']),
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense,
      ),

      paymentMethod: map['paymentMethod'] ?? 'Cash',
    );
  }
}
