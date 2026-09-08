import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spendly/core/theme/app-theme.dart';

class NameSetupScreen extends StatefulWidget {
  const NameSetupScreen({super.key});

  @override
  State<NameSetupScreen> createState() => _NameSetupScreenState();
}

class _NameSetupScreenState extends State<NameSetupScreen> {
  final TextEditingController _nameController = TextEditingController();

  // Regular expression allowing letters (including accented ones), spaces, hyphens, and apostrophes
  final RegExp _nameRegExp = RegExp(r"^[a-zA-Z\s\-\'\u00C0-\u024F]+$");

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _continue() {
    // Standardize spacing (collapses multiple inner spaces into one)
    final name = _nameController.text.trim().replaceAll(RegExp(r'\s+'), ' ');

    if (name.isEmpty) {
      _showError('Please enter your name');
      return;
    }

    if (name.length < 2) {
      _showError('Name must be at least 2 characters long');
      return;
    }

    if (name.length > 50) {
      _showError('Name cannot exceed 50 characters');
      return;
    }

    if (!_nameRegExp.hasMatch(name)) {
      _showError('Please enter a valid name (letters only)');
      return;
    }

    // Update the controller text with cleaned spacing
    _nameController.text = name;

    // Proceed with valid name
    // e.g., Navigator.push(...) or save to state management
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
              const SizedBox(height: 16),
              const Text(
                'This helps personalize your\nSpendly experience.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 42),
              const Text(
                'Your Name',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  // Prevents the user from typing numbers or non-name symbols
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s\-\'\u00C0-\u024F]")),
                  LengthLimitingTextInputFormatter(50),
                ],
                onSubmitted: (_) => _continue(),
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  suffixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: 50),
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
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}