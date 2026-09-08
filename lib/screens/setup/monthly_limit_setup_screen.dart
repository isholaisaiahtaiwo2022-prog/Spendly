import 'package:flutter/material.dart';

class MonthlyLimitSetupScreen extends StatefulWidget {
  final String name;

  const MonthlyLimitSetupScreen({super.key, required this.name});

  @override
  State<MonthlyLimitSetupScreen> createState() =>
      _MonthlyLimitSetupScreenState();
}

class _MonthlyLimitSetupScreenState extends State<MonthlyLimitSetupScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _continue() {
    final amountText = _amountController.text.trim();

    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Enter your Monthly Spending Limit'),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
