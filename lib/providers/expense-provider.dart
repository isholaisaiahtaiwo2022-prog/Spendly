import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly/models/expense.dart';

class Expenseprovider extends ChangeNotifier {
  String _name = '';
  double _monthlyLimit = 0.0;
  List<Expense> _expenses = [];
  bool _isLoading = true;

  // Keys for SharedPreferences
  static const String _keyName = 'user_name';
  static const String _keyLimit = 'monthly_limit';
  static const String _keyExpenses = 'user_expenses';
  static const String _keyIsSetupDone = 'user_setup_done';

  //Getters to read user setup
  String get name => _name;
  double get monthlyLimit => _monthlyLimit;
  List<Expense> get expenses => List.unmodifiable(_expenses);
  bool get isLoading => _isLoading;
  bool get isSetupComplete => _name.isNotEmpty && _monthlyLimit > 0;

  //Derived Business Logic
  double get totalSpent {
    return _expenses
        .where((e) => e.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get remaining => _monthlyLimit - totalSpent;
  int get expenseCount => _expenses.length;

  Future<void> loadSavedData() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_keyName) ?? '';
    _monthlyLimit = prefs.getDouble(_keyLimit) ?? 0.0;

    final String? expensesJsonString = prefs.getString(_keyExpenses);
    if (expensesJsonString != null && expensesJsonString.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(expensesJsonString);
        _expenses = decodedList
          .map((item) => Expense.fromMap(item as Map<String, dynamic>))
          .toList();
    } else {
      _expenses = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Save Onboarding / Limit Setup

  void setUserSetup(String name, double limit) async {
    _name = name;
    _monthlyLimit = limit;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setDouble(_keyLimit, limit);
    await prefs.setBool(_keyIsSetupDone, true);
  }

  // Add Transaction and sync to storage
  Future<void> addExpense(Expense expense) async {
    _expenses.insert(0, expense);
    notifyListeners();
    await _saveExpensesToDisk();
  }

  // private helper to serialize expense list to storage
  Future<void> _saveExpensesToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> mapList = _expenses
      .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e.toMap()))
        .toList();

    final String jsonString = jsonEncode(mapList);
    await prefs.setString(_keyExpenses, jsonString);
  }
}
