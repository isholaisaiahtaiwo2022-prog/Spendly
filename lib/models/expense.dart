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
}
