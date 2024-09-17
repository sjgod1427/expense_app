import 'package:expense_app/expens.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({required this.onAddExpense, super.key});

  final Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _ammountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _ammountController.dispose();
    super.dispose();
  }

  void _prensentDatePicker() async {
    final now = DateTime.now();
    final first = DateTime((now.year - 1), now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, firstDate: first, initialDate: now, lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredammount = double.tryParse(_ammountController.text);

    final _ammountInvalid = enteredammount == null || enteredammount <= 0;
    if (_titleController.text.trim().isEmpty ||
        _ammountInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctc) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text('Please enter a valid title and amount'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctc);
                      },
                      child: Text('Okay'))
                ],
              ));
      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredammount,
        date: _selectedDate!,
        category: _selectedCategory!));
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            if (width >= 600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text('Title')),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: TextField(
                      controller: _ammountController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                          label: Text('Ammount'), prefixText: '\$'),
                    ),
                  )
                ],
              )
            else
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
            if (width >= 600)
              Row(children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: (Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList()),
                  onChanged: (value) {
                    if (_selectedCategory == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const Spacer(),
                Text((_selectedDate == null
                    ? 'No  Date Selected'
                    : formatter.format(_selectedDate!))),
                IconButton(
                    onPressed: _prensentDatePicker,
                    icon: const Icon(Icons.calendar_month)),
              ])
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ammountController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                          label: Text('Ammount'), prefixText: '\$'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text((_selectedDate == null
                          ? 'No  Date Selected'
                          : formatter.format(_selectedDate!))),
                      IconButton(
                          onPressed: _prensentDatePicker,
                          icon: const Icon(Icons.calendar_month)),
                    ],
                  ))
                ],
              ),
            if (width >= 600)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: Text('Save Title'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  const SizedBox(width: 4),
                ],
              )
            else
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: (Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList()),
                    onChanged: (value) {
                      if (_selectedCategory == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: _submitExpenseData, child: Text('Save Title')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  const SizedBox(width: 4),
                ],
              ),
          ],
        ),
      );
    });
  }
}
