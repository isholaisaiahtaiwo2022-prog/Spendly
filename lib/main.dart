import 'package:flutter/material.dart';
import 'package:spendly/screens/splash/splash_screen.dart';
import 'core/theme/app-theme.dart';

void main() {
  runApp(const SplendyApp());
}

class SplendyApp extends StatelessWidget {
  const SplendyApp({super.key});

  @override   
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spendly',
      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
    );
  }
}
