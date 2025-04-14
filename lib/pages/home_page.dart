import 'package:flutter/material.dart';
import '../objectbox.dart';
import '../model.dart';
import 'add_transaction_page.dart';

class HomePage extends StatefulWidget {
  final ObjectBox objectBox;
  const HomePage({super.key, required this.objectBox});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Budget budget;
  List<TransactionModel> recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    budget = widget.objectBox.currentBudget;
    recentTransactions = widget.objectBox.transactionBox
        .getAll()
        .take(5)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Current Budget: \$${budget.total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  final t = recentTransactions[index];
                  return ListTile(
                    title: Text(t.info),
                    subtitle: Text('${t.category} • ${t.dateTime}'),
                    trailing: Text(
                      '\$${t.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: t.amount < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTransactionPage(objectBox: widget.objectBox),
            ),
          );
          _loadData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
