import 'package:expense_app/expens.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(expense.title, style: TextStyle(color: Colors.black)),
            const SizedBox(height: 4),
            Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                Text('   \$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    Text(expense.formattedDate),
                    const SizedBox(width: 8)
                  ],
                )
              ],
            ),
            const SizedBox(height: 10)
          ],
        )),
      ),
    );
  }
}
