import 'package:flutter/material.dart';
import 'package:spendly/models/expense.dart';
import 'package:spendly/screens/transactions/add_expense_screen.dart';
import 'package:spendly/screens/setup/monthly_limit_setup_screen.dart';

class Expenseprovider extends ChangeNotifier {
  String _name = '';
  double _monthlyLimit = 0.0;
  final List _expenses = [];

  //Getters to read user setup
  String get name => _name;
  double get monthlyLimit => _monthlyLimit;
  List get expenses => List.unmodifiable(_expenses);

  //Derived Business Logic
  double get totalSpent {
    return _expenses
        .where((e) => e.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get remaining => _monthlyLimit - totalSpent;
  int get expenseCount => _expenses.length;

  // Set user setup details (From onboarding)

  void setUserSetup(String name, double limit) {
    _name = name;
    _monthlyLimit = limit;
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }
}
