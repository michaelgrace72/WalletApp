import 'package:flutter/material.dart';
import '../objectbox.dart';
import '../model.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  final ObjectBox objectBox;
  const History({super.key, required this.objectBox});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<TransactionModel> allTransactions = [];

  @override
  void initState() {
    super.initState();
    allTransactions = widget.objectBox.transactionBox
        .getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: ListView.builder(
        itemCount: allTransactions.length,
        itemBuilder: (context, index) {
          final t = allTransactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(t.info),
              subtitle: Text('${t.category} • ${DateFormat('yyyy-MM-dd – kk:mm').format(t.dateTime)}'),
              trailing: Text(
                '${t.amount < 0 ? '-' : '+'}\$${t.amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  color: t.amount < 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
