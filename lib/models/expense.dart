import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();

const uuid =Uuid();

enum Category{ food, travel, buisness, loan}
const Categoryicons={
  Category.food : Icons.lunch_dining_rounded,
  Category.loan : Icons.monetization_on_rounded,
  Category.buisness: Icons.work,
  Category.travel : Icons.emoji_transportation_rounded,
};

class Expense{
  Expense({required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id=uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

 String  get FormattedDate{
   return formatter.format(date);
 }
}
class ExpenseBucket {
  const ExpenseBucket({required this.category,required this.expenses});


  ExpenseBucket.forCategory(List<Expense> allExpenses,this.category) : expenses=allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum=0;


    for(final expense in expenses){
      sum = sum + expense.amount;
    }

    return sum;
  }
}