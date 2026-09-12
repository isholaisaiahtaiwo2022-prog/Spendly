import 'package:flutter/material.dart';
import 'package:spendly/models/expense.dart';
import 'package:spendly/screens/expense/add_expense_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddAxpenseScreenState();
}

class _AddAxpenseScreenState extends State<AddExpenseScreen> {
  TransactionType _selectedType = TransactionType.expense;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
