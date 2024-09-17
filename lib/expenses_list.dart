import 'package:expense_app/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_app/expens.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final Function(Expense) onRemoveExpense;

  final List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(.50),
                margin: Theme.of(context).cardTheme.margin),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])));
  }
}
