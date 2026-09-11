import 'package:flutter/material.dart';

class Expenseprovider extends ChangeNotifier {
  String _name = '';
  double _monthlyLimit = 0.0;
  final List _expense = [];

  //Getters to read user setup
  String get name => _name;
  double
}
