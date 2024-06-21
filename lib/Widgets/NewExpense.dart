import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddexpense});

  final void Function(Expense expense) onAddexpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _datepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final lastdate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstdate,
      lastDate: lastdate,
      initialDate: now,
    );
    setState(() {
      // TODO: implement setState
      _selectedDate = pickedDate;
    });
  }

  void _submitExpensedata() {
    final enteredamount = double.tryParse(_amountController.text);
    final amountisinvalid = enteredamount == null || enteredamount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid input'),
                content: Text('please check all the values'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('OK'))
                ],
              ));
      return;
    }
    widget.onAddexpense(Expense(
        title: _titlecontroller.text,
        amount: enteredamount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard =MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyboard+16),
          child: Column(
            children: [
              TextField(
                maxLength: 20,
                controller: _titlecontroller,
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: InputDecoration(label: Text('Amount')),
                    ),
                  ),
                  SizedBox(
                    width: 36,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedDate == null
                            ? "no date selected"
                            : formatter.format(_selectedDate!),
                      ),
                      IconButton(
                          onPressed: _datepicker,
                          icon: Icon(Icons.date_range_outlined))
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        });
                      }),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  Spacer(),
                  ElevatedButton(
                      onPressed: _submitExpensedata, child: Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
