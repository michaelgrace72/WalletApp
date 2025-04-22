import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model.dart';
import '../objectbox.dart';

class AddTransactionPage extends StatefulWidget {
  final ObjectBox objectBox;

  const AddTransactionPage({super.key, required this.objectBox});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  final amountController = TextEditingController();
  final infoController = TextEditingController();
  String? selectedCategory;
  DateTime selectedDateTime = DateTime.now();

  @override
  void dispose() {
    amountController.dispose();
    infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.objectBox.categoryBox.getAll();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: infoController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat.name,
                          child: Text(cat.name),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                validator: (val) => val == null ? 'Select a category' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(selectedDateTime)}',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (date == null) return;

                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );
                      if (time == null) return;

                      setState(() {
                        selectedDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  final amount = double.parse(amountController.text);
                  final transaction = TransactionModel(
                    amount: amount,
                    info: infoController.text,
                    category: selectedCategory!,
                    dateTime: selectedDateTime,
                  );

                  widget.objectBox.transactionBox.put(transaction);

                  final budget = widget.objectBox.currentBudget;
                  budget.total += amount;
                  widget.objectBox.budgetBox.put(budget);

                  Navigator.pop(context);
                },
                child: const Text('Save Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
