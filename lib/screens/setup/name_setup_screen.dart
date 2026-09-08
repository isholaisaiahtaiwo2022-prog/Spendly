import 'package:flutter/material.dart';
import 'package:spendly/core/theme/app-theme.dart';

class NameSetupScreen extends StatefulWidget {
  const NameSetupScreen({super.key});

  @override
  State<NameSetupScreen> createState() => _NameSetupScreenState();
}

class _NameSetupScreenState extends State<NameSetupScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please Enter Your Name')));
      return;
    }
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
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What should\nwe call you?',
                style: TextStyle(
                  fontSize: 30,
                  height: 1.15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111111),
                  letterSpacing: -0.8,
                ),
              ),

              const SizedBox(height: 16,),

              const Text('This helps personalize your\n'
              'Spendly experience.',
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Color(0xFF666666),
                ),
              ),

              const SizedBox(
                height: 42,
              ),


              const Text(
                'Your Name',

                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333)
                ),
              ),


              const SizedBox(height: 8,),


              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                onSubmitted: (_) => _continue(),
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',

                  suffixIcon: Icon(Icons.person_outline_rounded)
                ),
              ),

              const SizedBox(height: 50,),


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
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text('Continue',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),)),
              )
            ],
          ),),
      ),
    );
  }
}
