import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_tracker/Widgets/expense_item.dart';
import 'package:new_tracker/models/expense.dart';
class Expenses_list extends StatelessWidget{

  const Expenses_list({super.key, required this.expenses,required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function (Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctxt,index)=>
            Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                margin: EdgeInsets.all(10),),
              
              key: ValueKey(expenses[index]),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);},
              child: Expense_item(expenses[index])
              ,)
    );
  }
}