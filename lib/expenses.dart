import 'package:expense_app/chart.dart';
import 'package:expense_app/expens.dart';
import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.9,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: 'Cinema',
        amount: 19.9,
        category: Category.leisure,
        date: DateTime.now()),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Exppense Deleted'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text('The Expense tracker is empty Add Some'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }
    return screenWidth < 600
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Expense tracker'),
              actions: [
                IconButton(
                    onPressed: _openAddExpenseOverlay,
                    icon: const Icon(Icons.add))
              ],
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            body: Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent)
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Expense tracker'),
              actions: [
                IconButton(
                    onPressed: _openAddExpenseOverlay,
                    icon: const Icon(Icons.add))
              ],
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            body: Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ));
  }
}
