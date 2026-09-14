import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spendly/core/theme/App-Theme.dart';
import 'package:spendly/models/expense.dart';
import 'package:spendly/providers/expense-provider.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddAxpenseScreenState();
}

class _AddAxpenseScreenState extends State<AddExpenseScreen> {
  TransactionType _selectedType = TransactionType.expense;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _SelectedCategory = 'Food';
  final DateTime _selectedDate = DateTime.now();
  final String _selectedPaymentMethod = 'Cash';

  final List _categories = [
    {'name': 'Food', 'icon': Icons.restaurant},
    {'name': 'Transport', 'icon': Icons.directions_car},
    {'name': 'Education', 'icon': Icons.school},
    {'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'name': 'More', 'icons': Icons.more_horiz},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveTransaction() {
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText.replaceAll(',', ' '));

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: const Text('Please enter a valid amount'),
        ),
      );
      return;
    }

    final title = _noteController.text.trim().isEmpty
        ? _SelectedCategory
        : _noteController.text.trim();

    final newExpense = Expense(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: _SelectedCategory,
      date: _selectedDate,
      type: _selectedType,
      paymentMethod: _selectedPaymentMethod,
    );

    context.read<Expenseprovider>().addExpense(newExpense);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBackground,
        elevation: 0,
        leading: IconButton(
          
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
          color: Colors.black87,)),
      ),
    ) ;
  }
}
