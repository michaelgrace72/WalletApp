import 'package:flutter/material.dart';
import '../objectbox.dart';
import '../model.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

class Reports extends StatefulWidget {
  final ObjectBox objectBox;
  const Reports({super.key, required this.objectBox});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  late Map<String, List<TransactionModel>> groupedByMonth;

  @override
  void initState() {
    super.initState();
    _groupTransactions();
  }

  void _groupTransactions() {
    final transactions = widget.objectBox.transactionBox.getAll();
    groupedByMonth = {};

    for (var t in transactions) {
      final monthKey = DateFormat('yyyy-MM').format(t.dateTime);
      groupedByMonth.putIfAbsent(monthKey, () => []).add(t);
    }

    // Sort by month descending
    groupedByMonth = SplayTreeMap<String, List<TransactionModel>>.from(
      groupedByMonth,
      (a, b) => b.compareTo(a),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monthly Reports')),
      body: ListView(
        children: groupedByMonth.entries.map((entry) {
          final income = entry.value
              .where((t) => t.amount > 0)
              .fold(0.0, (sum, t) => sum + t.amount);
          final expenses = entry.value
              .where((t) => t.amount < 0)
              .fold(0.0, (sum, t) => sum + t.amount);

          return ListTile(
            title: Text(DateFormat('MMMM yyyy').format(DateTime.parse('${entry.key}-01'))),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Income: \$${income.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
                Text('Expenses: \$${expenses.abs().toStringAsFixed(2)}', style: const TextStyle(color: Colors.red)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
