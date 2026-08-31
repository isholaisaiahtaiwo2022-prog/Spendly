import 'package:flutter/material.dart';
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

      home: const Scaffold(
        body: Center(
          child: Text(
            'Spendly',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
