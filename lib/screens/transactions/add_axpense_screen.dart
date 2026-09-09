import 'package:flutter/material.dart';
import 'package:spendly/models/expense.dart';

class AddAxpenseScreen extends StatefulWidget {
  const AddAxpenseScreen({super.key});

  @override
  State<AddAxpenseScreen> createState() => _AddAxpenseScreenState();
}

class _AddAxpenseScreenState extends State<AddAxpenseScreen> {
  TransactionType _selectedType = TransactionType.expense;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
