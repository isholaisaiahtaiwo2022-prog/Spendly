import 'package:flutter/material.dart';
import 'package:spendly/core/theme/app-theme.dart';
import 'package:spendly/models/expense.dart';
import 'package:spendly/screens/expense/add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final double monthlyLimit;

  const HomeScreen({super.key, required this.name, required this.monthlyLimit});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  double get _totalSpent {
    return _expenses
        .where((e) => e.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  double get _remaining => widget.monthlyLimit - _totalSpent;

  Future<void> _navigateToAddExpense() async {
    final result = await Navigator.of(context).push<Expense>(
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );

    if (result != null) {
      setState(() {
        _expenses.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final progress = widget.monthlyLimit   > 0 
    ? (_totalSpent / widget.monthlyLimit). clamp(0.0, 1.0)
    : 0.0; 
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              
            ],
          ),
        )
      ),
    );
  }
}
