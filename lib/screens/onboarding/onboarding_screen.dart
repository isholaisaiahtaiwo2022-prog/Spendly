import 'package:flutter/material.dart';
import 'package:spendly/core/theme/App-Theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _isPressed = false;

  void _getStarted() {
    // Name setup will be connected in the next milestone.
    // For now, this button provides visual feedback.

    setState(() {
      _isPressed = true;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;

      setState(() {
        _isPressed = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(  
            children: [
              const Expanded(child: _OnBoardingIllustration(),
              ),

              const SizedBox(
                height: 20,
              ).,


              const Text(
                'Welcome to\nSpendly 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
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


              const Text(
                'Your Personal Spending Tracker\n'
                'that helps you stay in control\n'
                'of your money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF666666),
                ),
              ),

              const SizedBox(
                  height: 32,
              )
            ],
          ),
      )
     ),
    );
  }
}
