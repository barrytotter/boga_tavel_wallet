import 'package:flutter/material.dart';

class ExpenseCategory {
  final String key;
  final String name;
  final IconData icon;
  final Color color;

  const ExpenseCategory({
    required this.key,
    required this.name,
    required this.icon,
    required this.color,
  });
}
