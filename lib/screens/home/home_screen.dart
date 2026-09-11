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
    final progress = widget.monthlyLimit > 0
        ? (_totalSpent / widget.monthlyLimit).clamp(0.0, 1.0)
        : 0.0;
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Good Evening 👋',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),

                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_outlined,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.darkScreen,
                  borderRadius: BorderRadius.circular(24),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Remaining this month',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      '₦${_remaining.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _remaining < 0 ? Colors.redAccent : Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white24,
                      color: progress >= 1.0
                          ? Colors.redAccent
                          : AppTheme.primaryGreen,
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          'Spent ₦${_totalSpent.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          'Limit ₦${widget.monthlyLimit.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Recent Transactions',

                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    'See all',

                    style: TextStyle(
                      color: AppTheme.primaryGreen,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (_expenses.isEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 36,
                    horizontal: 20,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: const [
                      Icon(
                        Icons.receipt_long_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 12),

                      Text(
                        'No Transactions Yet',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        'Your expenses will appear here',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    final item = _expenses[index];
                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),
                      child: ListTile(
                        title: Text(
                          item.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        ),

                        subtitle: Text(
                          item.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),

                        trailing: Text(
                          '-₦${item.amount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 15
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],


              const SizedBox(
                height: 24,
              ),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _navigateToAddExpense, 
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add Expanse',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
