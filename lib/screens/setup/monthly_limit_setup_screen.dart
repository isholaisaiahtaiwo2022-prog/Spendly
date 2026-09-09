import 'package:flutter/material.dart';
import 'package:spendly/core/theme/app-theme.dart';
import 'package:spendly/screens/home/home_screen.dart';

class MonthlyLimitSetupScreen extends StatefulWidget {
  final String name;

  const MonthlyLimitSetupScreen({super.key, required this.name});

  @override
  State<MonthlyLimitSetupScreen> createState() => _MonthlyLimitSetupScreenState();
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

    final amount = double.tryParse(amountText.replaceAll(',', ''));

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Text('Please enter a valid amount')),
      );
      return;
    }


    // Navigate to HomeScreen passing name and monthly limit
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => HomeScreen(
        name: widget.name,
        monthlyLimit: amount,
      ),
    ),
    (route) => false,
  );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.lightBackground,

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),



      body: SafeArea(child: 
      Padding(padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much do you\nwant to spend this month?',
            style: const TextStyle(
              fontSize: 30,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
              letterSpacing: -0.8,
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Text(
            'Set a monthly limit to help you stay\n'
            'in control of your spending, ${widget.name}.',

            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF666666)
            ),
          ),


          const SizedBox(
            height: 42,
          ),


          const Text(
            'Monthly Spending Limit',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _continue(),
            decoration: const InputDecoration(
              hintText: 'Enter amount',
              prefixText: '#',
              prefixStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              )
            ),
          ),


          const Spacer(),


          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _continue, 
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
              ),
              child: const Text(
                'continue',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600
                ),
              )
            ),
          )
        ],
      )
       )
      ),
    );
  }
}
