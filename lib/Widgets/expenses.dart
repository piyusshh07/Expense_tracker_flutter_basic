import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:new_tracker/Widgets/Expenses_list.dart';
import 'package:new_tracker/Widgets/NewExpense.dart';
import 'package:new_tracker/Widgets/chart/chart.dart';
import 'package:new_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> rregisteredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddexpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      rregisteredExpenses.add(expense);
    });
  }

  void _RemoveExpense(Expense expense) {
    final ExpenseIndex = rregisteredExpenses.indexOf(expense);
    setState(() {
      rregisteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              rregisteredExpenses.insert(ExpenseIndex, expense);
            });
          },
        ),
        content: Text('Expense deleted')));
  }

  @override
  Widget build(BuildContext context) {
  var width=  MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;
    Widget maincontent = const Center(
      child: Text('No expenses!! Add some!!'),
    );

    if (rregisteredExpenses.isNotEmpty) {
      maincontent = width < 600 ?Column(
        children: [
            Chart(
              expenses: rregisteredExpenses,
            ),

          Expanded(
              child: Expenses_list(
            expenses: rregisteredExpenses,
            onRemoveExpense: _RemoveExpense,
          ))
        ],
      ):
          Row(children: [
            Expanded(
              child: Chart(
                expenses: rregisteredExpenses,
              ),
            ),
            Expanded(
                child: Expenses_list(
                  expenses: rregisteredExpenses,
                  onRemoveExpense: _RemoveExpense,
                ))
          ],);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("flutter Expense tracker"),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: maincontent);
  }
}
