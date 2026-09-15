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
    {'name': 'More', 'icon': Icons.more_horiz},
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
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black87,
          ),
        ),

        title: const Text(
          'Add Expense',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),

        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(
                          () => _selectedType = TransactionType.expense,
                        ),

                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),

                          decoration: BoxDecoration(
                            color: _selectedType == TransactionType.income
                                ? Colors.white
                                : Colors.transparent,

                            borderRadius: BorderRadius.circular(25),
                            boxShadow: _selectedType == TransactionType.income
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 4,
                                    ),
                                  ]
                                : [],
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.call_received_rounded,
                                size: 16,

                                color: _selectedType == TransactionType.income
                                    ? AppTheme.primaryGreen
                                    : Colors.grey,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                'Income',

                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _selectedType == TransactionType.income
                                      ? Colors.black87
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Amount',

                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),

                decoration: InputDecoration(
                  prefixText: '₦ ',
                  prefixStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),

                  hintText: '0.00',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Category',

                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    final item = _categories[index];
                    final isSelected = _SelectedCategory == item['name'];


                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _SelectedCategory = item['name'];
                        });
                      },
                      child: Column(
                        children: [
                          AnimatedContainer(duration: Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryGreen : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),

                          child: Icon(
                            item['icon'],
                            color: isSelected ? Colors.white : Colors.grey
                          ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),


                          Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected ? AppTheme.primaryGreen : Colors.grey
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemCount: _categories.length,
                ),
              ),

              const SizedBox(
                height: 20,
              ),


              const Text(
                'Note (Optional)',

                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500
                ),
              ),


              const SizedBox(height: 8,),

              TextField(
                controller: _noteController,
                decoration: InputDecoration(
                  hintText: 'e.g Lunch with friends',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                  )
                )
              ),

              const SizedBox(height: 32,),


              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _saveTransaction,
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                   ),
                  child: const Text('Save Transaction',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
