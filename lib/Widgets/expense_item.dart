import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:new_tracker/models/expense.dart";

class Expense_item extends StatelessWidget{
  Expense_item(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
   return Card(
     child: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(expense.title,style: Theme.of(context).textTheme.titleLarge,),
           SizedBox(height: 4),
           Row(children: [
             Text(expense.amount.toStringAsFixed(2)),
             Spacer(),
             Row(
               children: [
                 Icon(Categoryicons[expense.category]),
                 SizedBox(width: 8,),
                 Text(expense.FormattedDate)
               ],
             ),
           ],)
         ],
       )
     ),
   )
  ;
  }

}